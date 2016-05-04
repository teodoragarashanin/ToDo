//
//  WebViewController.m
//  ToDo
//
//  Created by Cubes School 5 on 5/4/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIDynamicAnimator *animator;

@end



@implementation WebViewController

#pragma mark - Actions 

-(IBAction)closeButtonTapped {

    [self dismissViewControllerAnimated:YES completion:NULL];


}

#pragma mark - Private API

-(void) animateCloseButton {
    
 

}

#pragma mark - View lifecycle


-(void) viewDidLoad {

    [super viewDidLoad];
    self.closeButton.alpha = ZERO_VALUE;

   
}

-(void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear: animated];
    
     [self animateCloseButton];

}

-(void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear: animated];

}



-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}


#pragma mark - UIWebDelegate

//-(void) webViewDidStartLoad:(UIWebView *)webView {}

//-(void) webViewDidFinishLoad:(UIWebView *)webView {}

@end
