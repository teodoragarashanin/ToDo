//
//  LoginViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/30/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "LogInViewController.h"

#define kConstant 50.0

@interface LogInViewController()
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

-(void) configureTextFieldPlaceholders {
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont fontWithName:@"Avenir-Book" size:15.0] forKey:NSFontAttributeName];
    [attributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *usernamePlaceholder = [[NSAttributedString alloc] initWithString:self.usernameTextField.placeholder attributes:attributes];
    
    self.usernameTextField.attributedPlaceholder = usernamePlaceholder;
    
    
    NSAttributedString *passwordPlaceholder = [[NSAttributedString alloc] initWithString:self.passwordTextField.placeholder attributes:attributes];
    
    self.passwordTextField.attributedPlaceholder = passwordPlaceholder;
    
}

-(void) registerForNotifications {

    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
    {
        NSDictionary *keyboardInfo = note.userInfo;
        NSValue *keyboardFrameBegin = [keyboardInfo valueForKey: UIKeyboardFrameBeginUserInfoKey];
        CGRect keyboardFrameBeginRect = keyboardFrameBegin.CGRectValue;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.containerView.frame;
            frame.origin.y = self.view.frame.size.height - keyboardFrameBeginRect.size.height - self.containerView.frame.size.height;
            self.containerView.frame = frame;
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
         
         [UIView animateWithDuration:0.3 animations:^{
             CGRect frame = self.containerView.frame;
             frame.origin.y = self.containerViewOriginY;
             self.containerView.frame = frame;
         }];
     }];

    
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
    
    [UIView animateWithDuration:3.0 animations:^{
        self.maskLogoView.alpha = ZERO_VALUE;
    }];
    
    //button & footer & maskLogo
    [UIView animateWithDuration:0.4 delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                        CGRect submitButtonFrame = self.submitButton.frame;
                         submitButtonFrame.origin.x=0.0;
                         self.submitButton.frame=submitButtonFrame;
                         CGRect frame = self.footerView.frame;
                         frame.origin.y=625;
                         self.footerView.frame=frame;
                         //self.maskLogoView.alpha=0.0;
       }            completion:nil];
 
}

#pragma mark - Actions

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender {
    NSLog(@"Forgot password...");
}

-(IBAction)submitButtonTapped {

    if (self.usernameTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please enter your username."];
        return;
    }
    if (self.passwordTextField.text.length ==0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please enter your password."];
        return;
    }

    NSLog(@"Signing in . . . ");
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGGED_IN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.activityIndicatorView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
        [self performSegueWithIdentifier:@"HomeSegue" sender:self];
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
    [self configureTextFieldPlaceholders];
    [self registerForNotifications];
    self.containerViewOriginY = self.containerView.frame.origin.y;
    
   // [self configureTextField:self.usernameTextField];
   //[self configureTextField:self.passwordTextField];
  
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
    
    if (textField == self.usernameTextField) {
        self.usernameImageView.image = [UIImage imageNamed:@"username-active"];
    }
    
    if (textField == self.passwordTextField) {
        self.passwordImageView.image = [UIImage imageNamed:@"password-active"];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    self.usernameImageView.image = [UIImage imageNamed:@"username"];
    self.passwordImageView.image = [UIImage imageNamed:@"password"];
}


@end

//command+shift+f -  pretraga po kodu
//command+shift+o - trazi fajl