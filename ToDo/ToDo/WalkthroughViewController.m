//
//  WalkthroughViewController.m
//  ToDo
//
//  Created by Cubes School 5 on 4/22/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "Constants.h"

@implementation WalkthroughViewController

-(void) viewDidLoad {
    [super viewDidLoad];

}

-(IBAction)closeButtonTapped:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey: WALKTHROUGH_PRESENTED];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

@end