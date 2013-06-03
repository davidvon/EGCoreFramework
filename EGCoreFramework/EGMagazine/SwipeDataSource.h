//
//  AppDataSource.h
//  DishOrder
//
//  Created by feng guanhua on 13-4-29.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef AppDataSource_h
#define AppDataSource_h

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



#endif





