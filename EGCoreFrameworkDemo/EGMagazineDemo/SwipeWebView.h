//
//  SwipeWebView.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-5.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGCore/SwipeView.h"


@interface SwipeWebView : UIView<UIWebViewDelegate>{
    UIWebView *_webView;
}
@property (nonatomic, strong) NSString *currentModulePath;
@property (nonatomic, weak) id webVcDelegate;

- (id)initWithModule:(NSString*)module delegate:(id)delegate;
- (void) resetContentWithIndex:(int)index;
- (void) swipeViewDidScroll:(SwipeView *)swipeView;

@end


@protocol SwipeWebViewDelagate <NSObject>
-(void) gotoPage:(NSString*)pageName;
-(NSString*) pageNameByIndex:(NSInteger)index;
@end

