//
//  TimerViewController.m
//  ThePomodoro
//
//  Created by Alan Barth on 4/14/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import "TimerViewController.h"
#import "Timer.h"

@interface TimerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerForNotifications];
}
- (IBAction)timerButtonTapped:(id)sender {
    self.timeButton.enabled = NO;
    [[Timer sharedInstance] startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) updateTimerLabel {
    NSInteger minutes = [Timer sharedInstance].minutes;
    NSInteger seconds = [Timer sharedInstance].seconds;
    
    self.timeLabel.text = [self timerStringWithMinutes:minutes AndSeconds:seconds];
    
}
-(NSString *) timerStringWithMinutes: (NSInteger)minutes AndSeconds:(NSInteger)seconds {
    NSString * timerStringIAm;
    
    if (minutes >= 10) {
        timerStringIAm = [NSString stringWithFormat:@"%li", (long)minutes];
    }
    else {
        timerStringIAm = [NSString stringWithFormat:@"0%li", (long)minutes];
    }
    if (seconds >= 10) {
        timerStringIAm = [timerStringIAm stringByAppendingString:[NSString stringWithFormat:@"%li", (long)seconds]];
    }
    else {
        timerStringIAm = [timerStringIAm stringByAppendingString:[NSString stringWithFormat:@"0%li", (long)seconds]];
    }
    
    return timerStringIAm;
}
-(void) newRound {
    [self updateTimerLabel];
    self.timeButton.enabled = YES;
    
}
-(void) registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimerLabel) name: SecondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:NewRoundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound) name:RoundCompleteNotification object:nil];
}
-(void) unregisterFromNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void) dealloc {
    [self unregisterFromNotifications];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
