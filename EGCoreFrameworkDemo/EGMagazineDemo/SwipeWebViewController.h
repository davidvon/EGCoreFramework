//
//  SwipeWebViewController.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-27.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGCore/SwipeView.h"
#import "SwipeWebView.h"

#define kIsFirstTimeLaunch @"kIsFirstTimeLaunch"


@interface SwipeWebViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource, SwipeWebViewDelagate>

@property (nonatomic, strong) SwipeView *swipe;
@property (nonatomic, strong) NSMutableDictionary *datasource;
@property (nonatomic, strong) NSString *currentModule;

-(void) reloadData;
- (id)initWithModule:(NSString*)module;

@end
