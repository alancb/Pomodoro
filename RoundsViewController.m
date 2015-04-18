//
//  RoundsViewController.m
//  ThePomodoro
//
//  Created by Alan Barth on 4/14/15.
//  Copyright (c) 2015 Alan Barth. All rights reserved.
//

#import "RoundsViewController.h"
#import "RoundsController.h"
#import "Timer.h"

static NSString *const cellWithIdentifier = @"cellwithID";

@interface RoundsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [RoundsController sharedInstance].currentRound = indexPath.row;
    [[RoundsController sharedInstance]roundSelected];
    [[Timer sharedInstance]cancelTimer];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSArray *roundArray = [RoundsController sharedInstance].roundTimes;
    NSNumber *minutes = roundArray [indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[RoundsController imageNames] [indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%li minutes",(long)[minutes integerValue]]; //What does integerValue do?
    
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [RoundsController sharedInstance].roundTimes.count;
    
}

-(void) roundComplete {
    if ([RoundsController sharedInstance].currentRound < [RoundsController sharedInstance].roundTimes.count - 1) {
        [RoundsController sharedInstance].currentRound ++;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        //select row at index path
        [[RoundsController sharedInstance]roundSelected];
    }
    else {
        [RoundsController sharedInstance].currentRound = 0;
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[RoundsController sharedInstance].currentRound inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [[RoundsController sharedInstance]roundSelected];
        
    }
}
-(void) registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roundComplete) name:RoundCompleteNotification object:nil];
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
