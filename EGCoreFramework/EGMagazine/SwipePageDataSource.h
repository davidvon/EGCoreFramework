//
//  SwipePageDataSource.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-4-29.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//
#import <UIKit/UIKit.h>


#define APPLICATION_JSONFILE   @"application.json"
#define APPLICATION_JSONPATH   @"static"


#define Category_Widget_Animations      @"widget.animations"
#define Category_Widget_Swipings        @"widget.swipings"
#define Category_Widget_StaticImage     @"widget.static.image"

#define KEY_Image_Static                @"image"
#define KEY_Swiping                     @"swiping"
#define KEY_Animation_MoveX             @"animation.move.x"
#define KEY_Animation_MoveY             @"animation.move.y"
#define KEY_Animation_MoveLoopX         @"animation.move.loop.x"
#define KEY_Animation_MoveLoopY         @"animation.move.loop.y"
#define KEY_Animation_ImageShade        @"animation.image.shade"
#define KEY_Animation_ImageFadeIn       @"animation.image.fadein"
#define KEY_Animation_FadeIn            @"animation.fadein"
#define KEY_Animation_LoopFadeInOut     @"animation.loop.fadeinout"
#define KEY_Animation_LoopRetation      @"animation.loop.retation"

#define BACKGROUND_TRANS_DUR            60

typedef enum {
    Widget_NA,
    Widget_Image_Static,
    Widget_Swiping,
    Widget_Animation_Swiping,
    Widget_Animation_MoveX,
    Widget_Animation_MoveY,
    Widget_Animation_MoveLoopX,
    Widget_Animation_MoveLoopY,
    Widget_Animation_ImageShade,
    Widget_Animation_ImageFadeIn,
    Widget_Animation_FadeIn,
    Widget_Animation_LoopFadeInOut,
    Widget_Animation_LoopRetation,
}WidgetType;




@interface SwipePageDataSource : NSObject{
    NSMutableDictionary *json_datas;
}
@property (nonatomic) int currentCatagory;

-(int) getPageCount;
-(id)  getPage:(NSString*)pageName;
-(id)  getWidgetInPage:(NSString*)widgetName InPage:(NSString*)pageName;
-(NSString*) getPageFileNameByIndex:(int)index;
-(NSArray*) getAppViews;

+(WidgetType) widgetTypeFromDict:(NSDictionary*)dict;
+(SwipePageDataSource*) instance;

@end





