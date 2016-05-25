//
//  HomeViewController.m
//  ToDo
//
//  Created by Cubes School 5 on 4/8/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "HomeViewController.h"
#import "TaskTableViewCell.h"
#import "Constants.h"
#import "MenuView.h"
#import "WalkthroughViewController.h"
#import "WebViewController.h"
#import "DataManager.h"
#import "Task.h"
#import "Helpers.h"
#import "TaskDetailsViewController.h"
#import "WebViewController.h"
#import "TaskDetailsViewController.h"


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet MenuView *menuView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) Task *selectedTask;

@end

@implementation HomeViewController

#pragma mark - Properties

-(void) pickImage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"Choose source"
                                                                             message: nil
                                                                      preferredStyle: UIAlertControllerStyleActionSheet];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"Photo Librabry"
                                                         style: UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                           UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                                                           pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                                                           pickerController.delegate=self;
                                                           pickerController.allowsEditing=YES;
                                                           [self presentViewController: pickerController animated:YES completion:nil];
                                                           
                                                       }]];
    
    
    
    if ([UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront]) {
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Camera"
                                                            style: UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              
                                                              UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
                                                              pickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
                                                              pickerController.delegate=self;
                                                              pickerController.allowsEditing=YES;
                                                              [self presentViewController: pickerController animated:YES completion:nil];
                                                              
                                                              
                                                          }]];
    }
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style: UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          
                                                      }]];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSMutableArray *) itemsArray {

    _itemsArray = [[DataManager sharedInstance] fetchEntity:NSStringFromClass([Task class]) withFilter:nil withSortAsc:YES forKey:@"date"]; //ucitava iz bazeee
    return _itemsArray;

}

#pragma markv - View lifecycle

-(void) viewDidLoad {
    
    [super viewDidLoad];
    [self configurProfileImage];
    [self configureWelcomeLabel];
    
    //self.menuView.delegate = self; // povezan je delegat iz tabele u storyboardu
    self.tableView.tableFooterView = [[UIView alloc] init];
   

    // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    [self presentErrorWithTitle:@"Test" andError:@"GRESKA!"];
    //});
    
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    // [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:self];
     //});
    

}

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self configureBadge];

}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:WALKTHROUGH_PRESENTED]) {
        
        [self performSegueWithIdentifier: @"WalkthroughSegue" sender:self];
        
    }
    
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

#pragma mark - Sugue Management

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AboutSegue"]) {
        WebViewController *webViewController = (WebViewController *) segue.destinationViewController;
        webViewController.urlString = CUBES_URL;
    }
    
    if ([segue.identifier isEqualToString:@"TaskDetailsSegue"]) {
        TaskDetailsViewController *taskDetailsViewController = (TaskDetailsViewController *) segue.destinationViewController;
        taskDetailsViewController.task = self.selectedTask;
    }
}

#pragma mark - UITableViewDataSource 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemsArray.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   
    TaskTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier: @"Cell"];
    
    Task *task = [self.itemsArray objectAtIndex:indexPath.row];
    cell.task = task;
    return cell;
    
    //cell.task = self.itemsArray[indexPath.row];
    
    
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *task =[self.itemsArray objectAtIndex:indexPath.row];
        [[DataManager sharedInstance] deleteObjectInDatabase:task];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [tableView reloadData];
        [self configureBadge];
    }
    
}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Task *task = [self.itemsArray objectAtIndex:indexPath.row];
    self.selectedTask =task;
    [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:nil];

}

#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = [info objectForKey: UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey: UIImagePickerControllerOriginalImage];
    }
    
    self.userProfileImageView.image=image;
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    [[NSUserDefaults standardUserDefaults]setObject:data forKey:USER_IMAGE];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

#pragma mark - Private API

-(void)configureBadge {
    
    self.badgeImageView.alpha = (self.itemsArray.count == 0) ? ZERO_VALUE :1.0;
    self.badgeLabel.alpha = (self.itemsArray.count == 0) ? ZERO_VALUE :1.0;
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld", self.itemsArray.count];
}

-(void)configurProfileImage {

    self.userProfileImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                       action:@selector(pickImage)];
    tap.numberOfTapsRequired=1;
    [self.userProfileImageView addGestureRecognizer:tap];
    self.userProfileImageView.clipsToBounds=YES;
    self.userProfileImageView.layer.cornerRadius=self.userProfileImageView.frame.size.width/2;
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:USER_IMAGE]) {
        
        self.userProfileImageView.image=[[UIImage alloc]initWithData:[[NSUserDefaults standardUserDefaults]objectForKey:USER_IMAGE]];
        
    }
    

}

-(void)configureWelcomeLabel {
    
    if ([Helpers isMorning]) {
        self.welcomeLabel.text = @"Good Morning";
    } else {
        self.welcomeLabel.text = @"Good Afternoon";
    }
 
}

#pragma mark - MenuViewDelegate

-(void)menuViewOptionTapped:(MenuOption)option {


    switch (option) {
        case TASK_DETAILS_MENU_OPTION: {
            self.selectedTask = nil;
            [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:nil];
        } break;
            
        case ABOUT_MENU_OPTION: {
            [self performSegueWithIdentifier:@"AboutSegue" sender:nil];
        } break;
            
        case STATISTICS_MENU_OPTION: {
            [self performSegueWithIdentifier:@"StatisticsSegue" sender:nil];
        } break;
            
        case WALKTHROUGH_MENU_OPTION: {
            [self performSegueWithIdentifier:@"WalkthroughSegue" sender:nil];
        } break;
            
        default:
            break;
    }






}

@end
