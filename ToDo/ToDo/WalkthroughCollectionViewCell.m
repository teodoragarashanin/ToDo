//
//  WalkthroughCollectionViewCell.m
//  ToDo
//
//  Created by Cubes School 5 on 4/25/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "WalkthroughCollectionViewCell.h"
#import "WalkthroughItem.h"

@implementation WalkthroughCollectionViewCell

-(void) setWalkthroughItem:(WalkthroughItem *)walkthroughItem {

    _walkthroughItem=walkthroughItem;
    self.imageView.image=walkthroughItem.image;
    self.textLabel.text=walkthroughItem.text;
    
    self.textLabel.alpha=0.0;
    [UIView animateWithDuration:0.3 animations: ^{
    
        self.textLabel.alpha=1.0;
    }
     
     ];

}

@end
