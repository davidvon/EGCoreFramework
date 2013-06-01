//
//  Constant.m
//  DishOrder
//
//  Created by feng guanhua on 13-5-10.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "Constant.h"
#import "EGCore/JSONKit.h"

@implementation Constant
static NSDictionary *appJsonSettingsData = nil;

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
    [button setBackgroundImage: [UIImage imageNamed:image] forState:UIControlStateNormal];
    [view addSubview:button];
    return button;
}

@end





@implementation AppJsonDataSource

+(int) getWidgetCount:(NSString*)pageName
{
    if( !appJsonSettingsData ){
        NSError *error = [[NSError alloc] init];
        NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Static"] stringByAppendingPathComponent:@"application.json"];
        NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        appJsonSettingsData = [data objectFromJSONString];
    }
    NSDictionary *obj = [appJsonSettingsData valueForKey:pageName];
    if(obj){
        NSArray *list = [obj valueForKey:@"list"];
        return list.count;
    }
    return 0;
}


+(id) getPage:(NSString*)pageName
{
    NSError *error = [[NSError alloc] init];
    NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Static"] stringByAppendingPathComponent:pageName];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *dict = [data objectFromJSONString];
    return dict;
}


+(id) getWidgetFromPage:(NSString*)widgetName fromPage:(NSString*)pageName
{
    NSDictionary *dict = [AppJsonDataSource getPage:pageName];
    return [dict objectForKey:widgetName];
}



@end




