//
//  LogInViewController.m
//  ToDo
//
//  Created by Cubes School 5 on 3/30/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController()
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation LogInViewController

#pragma mark - Private API

-(void)configureTextField:(UITextField *) textField{
    
   if (textField.placeholder.length>0){
//        UIColor *color = [UIColor colorWithRed:117.0f/255.0f
//                                         green:113.0f/255.0f
//                                          blue:111.0f/255.0f
//                                         alpha:1.0f];
    
       NSDictionary *attributes=@{NSForegroundColorAttributeName: [UIColor whiteColor],
                               NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-Regular" size:14.0]};
    
    textField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:textField.placeholder
                                                                  attributes:attributes];
}
}

#pragma mark -View lifecycle
-(void) viewDidLoad{
    [super viewDidLoad];
    [self configureTextField:self.usernameTextField];
    [self configureTextField:self.passwordTextField];
}

#pragma mark - Actions

- (IBAction)signInButtonTapped:(UIButton *)sender {
}

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender {
}

- (IBAction)signUpButtonTapped:(UIButton *)sender {
}

@end