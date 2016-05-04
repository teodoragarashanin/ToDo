//
//  LoginViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/30/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "LogInViewController.h"

#define kConstant 50.0

@interface LogInViewController() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIView *maskLogoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation LogInViewController


#pragma mark - Private API

- (void)configureTextField:(UITextField *)textField {
    if (textField.placeholder.length > 0) {
//        UIColor *color = [UIColor colorWithRed:117.0/255.0
//                                         green:113.0/255.0
//                                          blue:111.0/255.0
//                                         alpha:1.0];
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:14.0],
                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                     };
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder
                                                                          attributes:attributes];
    }
}

#pragma mark - Public API

-(void) prepareForAnimations {
    
    //button
    CGRect submitButtonFrame = self.submitButton.frame;
    submitButtonFrame.origin.x=self.submitButton.frame.size.width;
    self.submitButton.frame=submitButtonFrame;
    
    //footer
    CGRect frame = self.footerView.frame;
    frame.origin.y=self.view.frame.size.height;
    self.footerView.frame=frame;
    self.maskLogoView.layer.cornerRadius=self.maskLogoView.frame.size.width/2;
}

-(void) animate {
    
    
    //button & footer & maskLogo
    [UIView animateWithDuration:0.4 delay:0.2
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                        CGRect submitButtonFrame = self.submitButton.frame;
                         submitButtonFrame.origin.x=0.0;
                         self.submitButton.frame=submitButtonFrame;
                         CGRect frame = self.footerView.frame;
                         frame.origin.y=625;
                         self.footerView.frame=frame;
                         self.maskLogoView.alpha=0.0;
       }            completion:nil];
 
}


#pragma mark - Actions

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender {
}

- (IBAction)signInButtonTapped:(UIButton *)sender {
    sender.enabled = NO;
    [self.activityIndicatorView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier: @"HomeSegue" sender: self];
        
    });
}

- (IBAction)signUpButtonTapped:(UIButton *)sender {
    NSLog(@"Sign up...");
}


#pragma mark - View lifecycle

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareForAnimations];
    [self.activityIndicatorView stopAnimating];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextField:self.usernameTextField];
    [self configureTextField:self.passwordTextField];
  
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self animate];
    
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:10.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y - kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y + kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];
}

@end