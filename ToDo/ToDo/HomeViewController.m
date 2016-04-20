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


@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;

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
    
    

}

#pragma mark - UITableViewDataSource 

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
   
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    TaskTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier: @"Cell"
                                                             forIndexPath: indexPath];
    cell.taskTitleLabel.text = [NSString stringWithFormat: @"Red %ld", indexPath.row];
    
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

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey: UIImagePickerControllerOriginalImage];
    }
    
    self.userProfileImageView.image=image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

#pragma mark - MenuViewDelegate

@end
