//
//  RoundsController.m
//  ThePomodoro
//
//  Created by Alan Barth on 4/14/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import "RoundsController.h"

@implementation RoundsController

+ (RoundsController *)sharedInstance {
    static RoundsController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundsController alloc] init];
        
       // [sharedInstance registerForNotifications];
    });
    return sharedInstance;
}

-(NSArray*) roundTimes {
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

@end
