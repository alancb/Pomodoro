//
//  Timer.m
//  ThePomodoro
//
//  Created by Alan Barth on 4/14/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import "Timer.h"

@interface Timer ()

@property (assign, nonatomic) BOOL isOn;

@end

@implementation Timer

+ (Timer *)sharedInstance {
    static Timer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [Timer new];
        
//        sharedInstance.minutes = 6;
//        sharedInstance.seconds = 5;
        
    });
    return sharedInstance;
}

-(void) startTimer {
    self.isOn = YES;
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
}

@end
