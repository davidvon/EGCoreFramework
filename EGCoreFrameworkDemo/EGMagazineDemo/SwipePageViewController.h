//
//  SwipePageViewController.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-27.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGCore/SwipeView.h"

@interface SwipePageViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource>

@property (nonatomic, strong) SwipeView *swipe;
@property (nonatomic, strong) NSMutableDictionary *datasource;
-(void) reloadData;
@end
