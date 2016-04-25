//
//  WalkthroughCollectionViewCell.h
//  ToDo
//
//  Created by Cubes School 5 on 4/25/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkthroughItem.h"


@interface WalkthroughCollectionViewCell : UICollectionViewCell



@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) WalkthroughItem *walkthroughItem;

@end
