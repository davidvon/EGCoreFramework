//
//  SwipeWebView.m
//
//  Created by feng guanhua on 13-5-5.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SwipeWebView.h"
#import "EGCore/Constant.h"
#import "EGCore/PathFile.h"
#import "SwipeWebViewController.h"

@implementation SwipeWebView
@synthesize currentModulePath, webVcDelegate;

- (id)initWithModule:(NSString*)module
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 1024, 768);
        currentModulePath = [[[PathFile documentPath] stringByAppendingPathComponent:@"modules"] stringByAppendingPathComponent:module];
        _webView = [Constant createWebView:self.frame];
        _webView.delegate = self;
        [self addSubview:_webView];
    }
    return self;
}


-(void) resetContentWithIndex:(int)index
{
    [self updateView:index];
}


-(void) updateView:(int)index
{
    NSString *indexFile = [NSString stringWithFormat:@"%d.html", index];
    NSString *url = [currentModulePath stringByAppendingPathComponent: indexFile];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
    [_webView loadRequest:request];
}


- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    //DON'T DELETE
}

-(int) getPageIndex: (NSString*)url
{
    NSString *suffix = @".html";
    NSArray *chunks = [url componentsSeparatedByString: @"/"];
    NSString *name = [chunks objectAtIndex:chunks.count-1];
    int pageIndex = [[name substringToIndex:suffix.length] integerValue];
    return pageIndex;
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.relativeString;
    int pageIndex = [self getPageIndex:url];
 
    if( navigationType == UIWebViewNavigationTypeLinkClicked ){
        [webVcDelegate gotoPage:pageIndex];
        return false;
    }
    return true;
}

@end



