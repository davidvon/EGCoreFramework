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

#define Category_Widget_Animations           @"widget.animations"
#define Category_Widget_Swipings             @"widget.swipings"
#define Category_Widget_StaticImage          @"widget.static.image"

#define KEY_Image_Static                @"image.static"
#define KEY_Swiping                     @"swiping"
#define KEY_Animation_MoveX             @"animation.move.x"
#define KEY_Animation_MoveY             @"animation.move.y"
#define KEY_Animation_ImageShading      @"animation.imageshading"

#define BACKGROUND_TRANS_DUR      60

typedef enum {
    Widget_Image_Static,
    Widget_Swiping,
    Widget_Animation_Swiping,
    Widget_Animation_MoveX,
    Widget_Animation_MoveY,
    Widget_Animation_ImageShading,
}WidgetType;





@interface SwipePageView : UIView{
    KenBurnsView *kenView;
}

@property (nonatomic, strong) NSMutableArray *widgets;
@property (nonatomic, strong) NSDictionary *json_data;

- (void) resetContentWithIndex:(int)index;
- (void) swipeViewDidScroll:(SwipeView *)swipeView;

@end


