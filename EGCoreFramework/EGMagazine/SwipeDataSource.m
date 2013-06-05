//
//  SwipeDataSource.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-10.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipeDataSource.h"
#import "EGCore/JSONKit.h"

@implementation SwipeDataSource
@synthesize currentCatagory;

-(id) init {
    self = [super init];
    json_datas = [[NSMutableDictionary alloc] init];
    NSError *error = [[NSError alloc] init];
    NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:APPLICATION_JSONPATH] stringByAppendingPathComponent:APPLICATION_JSONFILE];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *app_data = [data objectFromJSONString];
    [json_datas setObject:app_data forKey:@"application"];
    
    currentCatagory = 1;
    return self;
}


+(SwipeDataSource*) instance
{
    static SwipeDataSource *datasource = nil;
    if( !datasource ){
        datasource = [[SwipeDataSource alloc] init];
    }
    return datasource;
}


-(int) getPageCount
{
    NSDictionary *json_file_content =  [json_datas valueForKey:@"application"];
    NSArray *list = [json_file_content valueForKey:@"category"];
    NSLog(@"count=%d", list.count);
    return list.count;
}


-(id) getPage:(NSString*)pageName
{
    NSDictionary *json_file_content = [json_datas valueForKey:pageName];
    if( json_file_content.count == 0 ){
        NSError *error = [[NSError alloc] init];
        NSString *path = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:APPLICATION_JSONPATH] stringByAppendingPathComponent:pageName];
        NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if(!data) return nil;
        json_file_content = [data objectFromJSONString];
        if(json_file_content) [json_datas setObject:json_file_content forKey:pageName];
    }
    return json_file_content;
}


-(id) getWidgetInPage:(NSString*)widgetName InPage:(NSString*)pageName
{
    NSDictionary *dict = [self getPage:pageName];
    return [dict objectForKey:widgetName];
}


-(NSString*) getPageFileNameByIndex:(int)index
{
    NSDictionary *json_file_content =  [json_datas valueForKey:@"application"];
    NSArray *list = [json_file_content valueForKey:@"category"];
    if( list.count > index ){
        return [list objectAtIndex:index];
    }
    return @"";
}


+(WidgetType) widgetTypeFromDict:(NSDictionary*)dict
{
    NSString *type = [dict objectForKey:@"type"];
    if( [type isEqualToString:KEY_Image_Static])                return Widget_Image_Static;
    if( [type isEqualToString:KEY_Swiping])                     return Widget_Swiping;
    if( [type isEqualToString:KEY_Animation_MoveX] )            return Widget_Animation_MoveX;
    if( [type isEqualToString:KEY_Animation_MoveY] )            return Widget_Animation_MoveY;
    if( [type isEqualToString:KEY_Animation_ImageShade] )       return Widget_Animation_ImageShade;
    if( [type isEqualToString:KEY_Animation_ImageFadeIn] )      return Widget_Animation_ImageFadeIn;
    return Widget_Animation_Swiping;
}


@end




