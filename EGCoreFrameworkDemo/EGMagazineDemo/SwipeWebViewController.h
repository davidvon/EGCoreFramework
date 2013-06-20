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
#import "SGdownloader.h"
#import "UpdateViewController.h"

#define kIsFirstTimeLaunch @"kIsFirstTimeLaunch"
#define kAppJsonFile       @"app.json"
#define kUpdateDate        @"update.date"

@interface SwipeWebViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource, SwipeWebViewDelagate>{
    bool _isIndexJsonFileExist;
}

@property (nonatomic, strong) SwipeView *swipe;
@property (nonatomic, strong) NSMutableDictionary *datasource;
@property (nonatomic, strong) NSString *currentModule;
@property (nonatomic, strong) NSString *modulePath;
@property (nonatomic, strong) NSArray *pageList;
@property (nonatomic, strong) NSDate  *updateDate;
@property (nonatomic, strong) SGdownloader *downloader;
@property (nonatomic, strong) UIPopoverController *updatePopVc;

-(void) reloadData;
- (id)initWithModule:(NSString*)module;

-(bool) updateVerifyZipFile:(NSString*)zipFile;
@end
