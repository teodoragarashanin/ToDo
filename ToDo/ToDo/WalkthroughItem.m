//
//  WalkthroughItem.m
//  ToDo
//
//  Created by Cubes School 5 on 4/25/16.
//  Copyright © 2016 Cubes School 5. All rights reserved.
//

#import "WalkthroughItem.h"

@implementation WalkthroughItem

-(instancetype) initWithText: (NSString *) text andImage:(UIImage *)image {
    
    if (self = [super init]) {
    
    self.text=text;
    self.image=image;
        
    }
    
    return self;
}

@end
