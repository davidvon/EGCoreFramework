//
//  Constant.m
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-3.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "Constant.h"


@implementation Constant

+(UILabel*) addLabel: (CGRect)frame bgColor:(UIColor*)bgColor inView:(UIView*)view
{
    UILabel *unit = [[UILabel alloc] initWithFrame:frame];
    [unit setBackgroundColor: bgColor];
    [view addSubview:unit];
    return unit;
}


+(UILabel*) addLabel: (CGRect)frame bgColor:(UIColor*)bgColor txtColor:(UIColor*)txtColor fontSize:(NSInteger)size withText:(NSString*)text inView:(UIView*)view
{
    UILabel *unit = [[UILabel alloc] initWithFrame:frame];
    [unit setBackgroundColor: bgColor];
    [unit setFont:[UIFont boldSystemFontOfSize:size]];
    [unit setTextColor: txtColor];
    [unit setText:text];
    [view addSubview:unit];
    return unit;
}


+ (UIImageView*) addImageView: (CGRect)rect withImageName:(NSString*)imageName inView:(UIView*)view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = rect;
    [view addSubview:imageView];
    return imageView;
}


+ (UILabel*) addPatternImageView: (CGRect)rect withImageName:(NSString*)imageName inView:(UIView*)view;
{
	NSString* path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:path]];
    [view addSubview:label];
    return label;
}


+ (UIButton*) addButton: (CGRect)rect withImageList:(NSArray*)imageList fontSize:(NSInteger)size withText:(NSString*)text inView:(UIView*)view
{
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setBackgroundImage: [UIImage imageNamed:[imageList objectAtIndex:0] ] forState:UIControlStateNormal];
    if([imageList count]>1) [button setBackgroundImage:[UIImage imageNamed:[imageList objectAtIndex:1]] forState:UIControlStateHighlighted];
    if([imageList count]>2) [button setBackgroundImage:[UIImage imageNamed:[imageList objectAtIndex:2]] forState:UIControlStateSelected];
    
    [button setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    
    [view addSubview:button];
    return button;
}


+ (UIButton*) addButton: (CGRect)rect withImage:(NSString*)image inView:(UIView*)view;
{
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    if( image.length >0 ) [button setBackgroundImage: [UIImage imageNamed:image] forState:UIControlStateNormal];
    [view addSubview:button];
    return button;
}

+ (UIButton*) addButton: (CGRect)rect withImageList:(NSArray*)imageList inView:(UIView*)view
{
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setBackgroundImage: [UIImage imageNamed:[imageList objectAtIndex:0] ] forState:UIControlStateNormal];
    if([imageList count]>1) [button setBackgroundImage:[UIImage imageNamed:[imageList objectAtIndex:1]] forState:UIControlStateHighlighted];
    if([imageList count]>2) [button setBackgroundImage:[UIImage imageNamed:[imageList objectAtIndex:2]] forState:UIControlStateSelected];

    [view addSubview:button];
    return button;
}



+(UIScrollView*) addScrollView:(CGRect)rect inView:(UIView*)view
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = CLEAR_COLOR;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setScrollEnabled:YES];
    scrollView.frame = rect;
    [view addSubview:scrollView];
    return scrollView;
}



+(UIWebView*) createWebView:(CGRect)rect
{
    UIWebView *webView =[[UIWebView alloc] initWithFrame:rect];
    webView.opaque = NO;
    webView.backgroundColor = GLOBAL_BG_COLOR;
    for (UIView *view in [webView subviews]){
        if ([view isKindOfClass:[UIScrollView class]]){
            for (UIView *shadowView in view.subviews){
                if ([shadowView isKindOfClass:[UIImageView class]]){
                    shadowView.hidden = YES;
                }
            }
        }
    }
    return webView;
}


+(UIWebView*) loadWebView:(CGRect)rect withUrlPath:(NSString*)path
{
    UIWebView *webView = [Constant createWebView:rect];
    NSString *url = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
    [webView loadRequest:request];
    return webView;
}


+(void) reloadWebViewContent:(UIWebView*)webView withUrlPath:(NSString*)path
{
    NSString *url = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:url]];
    [webView loadRequest:request];
}

@end


