//
//  Constant.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-10.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "AppDataSource.h"
#import "EGCore/JSONKit.h"

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
    [button setBackgroundImage: [UIImage imageNamed:image] forState:UIControlStateNormal];
    [view addSubview:button];
    return button;
}

@end






@implementation AppDataSource
@synthesize currentCatagory;

-(id) init {
    self = [super init];
    json_datas = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc] init];
    NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Static"] stringByAppendingPathComponent:@"application.json"];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *app_data = [data objectFromJSONString];
    [json_datas setObject:app_data forKey:@"application"];
    
    currentCatagory = 1;
    return self;
}


-(int) getWidgetCountInJson:(NSString*)pageName
{
    NSDictionary *json_file_content =  [json_datas valueForKey:@"application"];
    NSDictionary *obj = [json_file_content valueForKey:pageName];
    if(obj){
        NSArray *list = [obj valueForKey:@"list"];
        NSLog(@"count=%d", list.count);
        return list.count;
    }
    return 0;
}


-(int) getCategoryCountInJson
{
    NSDictionary *json_file_content =  [json_datas valueForKey:@"application"];
    NSDictionary *obj = [json_file_content valueForKey:@"categories"];
    if(obj){
        int sum = [[obj valueForKey:@"sum"] integerValue];
        NSLog(@"sum=%d", sum);
        return sum;
    }
    return 0;
}



-(id) getPageInJson:(NSString*)pageName
{
    NSDictionary *json_file_content = [json_datas valueForKey:pageName];
    if( json_file_content.count == 0 ){
        NSError *error = [[NSError alloc] init];
        NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Static"] stringByAppendingPathComponent:pageName];
        NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        json_file_content = [data objectFromJSONString];
        [json_datas setObject:json_file_content forKey:pageName];
    }
    return json_file_content;
}


-(id) getWidgetFromPageInJson:(NSString*)widgetName fromPage:(NSString*)pageName
{
    NSDictionary *dict = [self getPageInJson:pageName];
    return [dict objectForKey:widgetName];
}


+(AppDataSource*) instance
{
    static AppDataSource *datasource = nil;
    if( !datasource ){
        datasource = [[AppDataSource alloc] init];
    }
    return datasource;
}

@end




