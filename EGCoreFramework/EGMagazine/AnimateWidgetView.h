//
//  AnimateWidgetView.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-28.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipePageView.h"
#import "SwipeDataSource.h"

@interface AnimateWidgetView : UIView{
    WidgetType widgetType;
    int   destination;
    float duration;
    float delay;
}
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDictionary *reflectionInfo;
@property (nonatomic, strong) NSMutableArray *animationGroupInfo;

- (id) initWithJsonDict:(NSDictionary *)dict;
- (void) swipeViewDidScroll:(float)offset withIndex:(int) index;
- (void) animate;
@end

