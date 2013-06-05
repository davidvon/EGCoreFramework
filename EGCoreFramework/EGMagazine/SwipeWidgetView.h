//
//  SwipePageWidgetView.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-28.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipePageView.h"
#import "SwipeDataSource.h"

@interface SwipeWidgetView : UIView{
    WidgetType widgetType;
    int   destination;
    float duration;
    float delay;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *reflectionInfo;

- (id)initWithParams:(CGRect)widgetFrame dest:(int)xy image:(NSString*)name durnation:(float)dur delay:(float)del withMainViewFrame:(CGRect)mainFrame ofType:(WidgetType)wtype;
- (id)initWithJsonDict:(NSDictionary *)dict;

- (void)swipeViewDidScroll:(float)offset withIndex:(int) index;
- (void) animate;
@end

