//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Cubes School 5 on 5/4/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "StatisticsViewController.h"


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

}

-(UIStatusBarStyle) preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;

}


@end
