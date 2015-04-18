//
//  Timer.m
//  ThePomodoro
//
//  Created by Alan Barth on 4/14/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import "Timer.h"
@import UIKit;

static NSString * ExpiriDate = @"Expiration Date";


@interface Timer ()

@property (assign, nonatomic) BOOL isOn;
@property (strong, nonatomic) NSDate* expirationDate;


@end

@implementation Timer

+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [Timer new];
        
    });
    return sharedInstance;
}

-(void) prepareForBackground {
    [[NSUserDefaults standardUserDefaults] setObject:self.expirationDate forKey:ExpiriDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) loadFromBackground {
    self.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:ExpiriDate];
    NSTimeInterval seconds = [self.expirationDate timeIntervalSinceNow];
    self.minutes = seconds / 60;
    self.seconds = seconds - (self.minutes * 60);
}

-(void) startTimer {
    self.isOn = YES;

    NSTimeInterval timelength = self.minutes * 60 + self.seconds;
    self.expirationDate = [NSDate dateWithTimeIntervalSinceNow: timelength];
    
    UILocalNotification *timeExpiredNotification = [UILocalNotification new];
    timeExpiredNotification.fireDate = self.expirationDate;
    timeExpiredNotification.timeZone = [NSTimeZone defaultTimeZone];
    timeExpiredNotification.soundName = UILocalNotificationDefaultSoundName;
    timeExpiredNotification.alertBody = @"Round Complete, Continue with Next Round";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:timeExpiredNotification];
    
    [self checkActive];
}

-(void) endTimer {
    self.isOn = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:RoundCompleteNotification object:nil];
}
-(void) checkActive {
    // The instructions say "before the if statement, make sure you cancel previous perform requests"
    // What does that mean?
    if (self.isOn) {
        [self decreaseSecond];
        [self performSelector:@selector(checkActive) withObject:nil afterDelay:1.0];
    }
    
}
-(void) decreaseSecond {
    if (self.seconds > 0) {
        self.seconds --;
        [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    }
    else if (self.seconds == 0 && self.minutes >0) {
        self.minutes --;
        self.seconds = 59;
        [[NSNotificationCenter defaultCenter] postNotificationName:SecondTickNotification object:nil];
    }
    else {
        [self endTimer];

    }
}
-(void) cancelTimer {
    self.isOn = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self]; //This is new. Not sure about it still.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

@end
