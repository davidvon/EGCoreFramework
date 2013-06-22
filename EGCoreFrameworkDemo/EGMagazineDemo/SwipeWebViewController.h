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
#define kWebUrl            @"web.url" 
#define kUpdateNotifyKey   @"UpdateNotifyKey" 

#define kWebsite @"http://d.pcs.baidu.com/file/f2ac2a13919c3a72eb7d9e01f0ad4dfd?fid=1477463264-250528-474030780&time=1371742968&sign=FDTAR-DCb740ccc5511e5e8fedcff06b081203-0fhOIaDogfhsBWW8VcEl6w2BlwI%3D&rt=sh&expires=8h&r=389841589&sh=1&response-cache-control=private"


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


- (id)initWithModule:(NSString*)module;
-(bool) updateVerifyZipFile:(NSString*)zipFile;
@end
