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


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MenuViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet MenuView *menuView;
@end

@implementation HomeViewController

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

#pragma markv - View lifecycle

-(void) viewDidLoad {
    
    [super viewDidLoad];
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
    
   // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    [self performSegueWithIdentifier:@"AboutSegue" sender:self];
   // });
    
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self performSegueWithIdentifier:@"StatisticsSegue" sender:self];
     });
    */
    


}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:WALKTHROUGH_PRESENTED]) {
        
    //[self performSegueWithIdentifier: @"WalkthroughSegue" sender:self];
        
    }
    
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

#pragma mark - UITableViewDataSource 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   
    TaskTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier: @"Cell"
                                                             forIndexPath: indexPath];
    cell.taskTitleLabel.text = [NSString stringWithFormat: @"Red %long", indexPath.row];
    
    switch (indexPath.row) {
        case COMPLETED_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kTurquoiseColor;
            break;
        case NOT_COMPLETED_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kOrangeColor;
            break;
            
        case IN_PROGRESS_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kPurpleColor;
            break;
        default:
            cell.taskGroupView.backgroundColor = kTurquoiseColor;
            break;
    }
    
    
    return cell;
    
    
    
}


#pragma mark - UITableViewDelegate

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
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

#pragma mark - MenuViewDelegate

-(void)menuViewOptionTapped:(MenuOption)option {}


@end
