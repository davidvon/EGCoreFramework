//
//  SwipePageView.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-5.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGCore/SwipeView.h"
#import "EGCore/JBKenBurnsView.h"

#define D_WIDGET_ANIMATIONS     @"widget.animations"
#define D_WIDGET_SWIPINGS       @"widget.swipings"
#define D_WIDGET_STATIC_IMAGE   @"widget.static.image"

#define KEY_IMAGE               @"image"
#define KEY_SWIPIING            @"swiping"
#define KEY_ANIMATION           @"animation"


typedef enum {
    WIDGET_STATIC_IMAGE,
    WIDGET_SWIPING,
    WIDGET_ANIMATION,
    WIDGET_ANIMATION_SWIPING,
}WidgetType;


typedef enum {
    MOVE_X,
    MOVE_Y,
}AnimationType;





@interface SwipePageView : UIView{
    KenBurnsView *kenView;
}

@property (nonatomic, strong) NSMutableArray *widgets;
@property (nonatomic, strong) NSDictionary *json_data;

- (void) resetContentWithIndex:(int)index;
- (void) swipeViewDidScroll:(SwipeView *)swipeView;

@end


