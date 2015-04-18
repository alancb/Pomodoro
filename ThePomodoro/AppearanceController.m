//
//  AppearanceController.m
//  ThePomodoro
//
//  Created by Alan Barth on 4/15/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import "AppearanceController.h"
#import <UIKit/UIKit.h>
#import "TimerViewController.h"
#import "RoundsController.h"


@implementation AppearanceController

+(void) initializeAppearanceDefaults {
    [[UINavigationBar appearance] setBarTintColor:[UIColor blueColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"Avenir-Light" size: 20]}];
    [[UITabBar appearance] setTintColor:[UIColor blueColor]];

    [[UITableView appearance] setSeparatorColor:[UIColor blueColor]];

}
@end
