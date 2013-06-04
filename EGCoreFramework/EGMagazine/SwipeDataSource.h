//
//  SwipeDataSource.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-4-29.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//
#import <UIKit/UIKit.h>


#define APPLICATION_JSONFILE   @"application.json"
#define APPLICATION_JSONPATH   @"Static"


@interface SwipeDataSource : NSObject{
    NSMutableDictionary *json_datas;
}
@property (nonatomic) int currentCatagory;

-(int) getPageCount;
-(id)  getPage:(NSString*)pageName;
-(id)  getWidgetInPage:(NSString*)widgetName InPage:(NSString*)pageName;
-(NSString*) getPageFileNameByIndex:(int)index;

+(SwipeDataSource*) instance;
@end





