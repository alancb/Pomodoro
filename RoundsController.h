//
//  RoundsController.h
//  ThePomodoro
//
//  Created by Alan Barth on 4/14/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundsController : NSObject

@property (assign, nonatomic) NSInteger currentRound;
@property (strong, nonatomic, readonly) NSArray *roundTimes;

+ (RoundsController *)sharedInstance;
-(void) roundSelected;

@end
