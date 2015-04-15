//
//  Timer.h
//  ThePomodoro
//
//  Created by Alan Barth on 4/14/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const SecondTickNotification = @"Secondtick";
static NSString *const RoundCompleteNotification = @"RoundComplete";
static NSString *const NewRoundNotification = @"NewRound";

@interface Timer : NSObject

@property (assign, nonatomic) NSInteger minutes;
@property (assign, nonatomic) NSInteger seconds;

@end
