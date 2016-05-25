//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Cubes School 5 on 5/4/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "StatisticsViewController.h"
#import "DataManager.h"


@interface StatisticsViewController  ()

@property (weak, nonatomic) IBOutlet UILabel *completedPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonCompletedPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *nonCompletedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressCountLabel;

@end


@implementation StatisticsViewController

#pragma mark - Actions

- (IBAction)backButtonTapped {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark - View lifecycle

-(void) viewDidLoad {
    
    [super viewDidLoad];
    
    CGFloat completedCount = [[DataManager sharedInstance] numberOfTasksPerTaskGroup:COMPLETED_TASK_GROUP];
    CGFloat notCompletedCount = [[DataManager sharedInstance] numberOfTasksPerTaskGroup:NOT_COMPLETED_TASK_GROUP];
    CGFloat inProgressCount = [[DataManager sharedInstance] numberOfTasksPerTaskGroup:IN_PROGRESS_TASK_GROUP];
    CGFloat tasksCount = completedCount + notCompletedCount + inProgressCount;
    
    self.completedCountLabel.text = [NSString stringWithFormat:@"%.0f", completedCount];
    self.nonCompletedCountLabel.text = [NSString stringWithFormat:@"%.0f", notCompletedCount];
    self.inProgressCountLabel.text = [NSString stringWithFormat:@"%.0f", inProgressCount];
    
    if (completedCount > 0) {
        CGFloat percentage = (completedCount/tasksCount)*100;
        self.completedPercentageLabel.text = [NSString stringWithFormat:@"%.0f", percentage];
        
    } else {
        
        self.completedPercentageLabel.text = @"0";
    }
    
    
    if (notCompletedCount > 0) {
        CGFloat percentage = (notCompletedCount/tasksCount)*100;
        self.nonCompletedPercentageLabel.text = [NSString stringWithFormat:@"%.0f", percentage];
        
    } else {
        
        self.nonCompletedPercentageLabel.text = @"0";
    }
    
    if (inProgressCount > 0) {
        CGFloat percentage = (inProgressCount/tasksCount)*100;
        self.inProgressPercentageLabel.text = [NSString stringWithFormat:@"%.0f", percentage];
        
    } else {
        
        self.inProgressPercentageLabel.text = @"0";
    }

}

-(UIStatusBarStyle) preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;

}


@end
