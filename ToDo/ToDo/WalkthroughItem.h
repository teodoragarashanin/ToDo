//
//  WalkthroughItem.h
//  ToDo
//
//  Created by Cubes School 5 on 4/25/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WalkthroughItem : NSObject


@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) UIImage *image;

-(instancetype) initWithText: (NSString *) text andImage:(UIImage *)image;
@end
