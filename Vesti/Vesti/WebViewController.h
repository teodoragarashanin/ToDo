//
//  WebViewController.h
//  Vesti
//
//  Created by Djuro Alfirevic on 4/26/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface WebViewController : UIViewController
@property (strong, nonatomic) Article *article;
@end