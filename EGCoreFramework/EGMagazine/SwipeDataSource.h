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


#define Category_Widget_Animations      @"widget.animations"
#define Category_Widget_Swipings        @"widget.swipings"
#define Category_Widget_StaticImage     @"widget.static.image"

#define KEY_Image_Static                @"image.static"
#define KEY_Swiping                     @"swiping"
#define KEY_Animation_MoveX             @"animation.move.x"
#define KEY_Animation_MoveY             @"animation.move.y"
#define KEY_Animation_ImageShade        @"animation.image.shade"
#define KEY_Animation_ImageFadeIn       @"animation.image.fadein"
#define KEY_Animation_FadeIn            @"animation.fadein"

#define BACKGROUND_TRANS_DUR            60

typedef enum {
    Widget_Image_Static,
    Widget_Swiping,
    Widget_Animation_Swiping,
    Widget_Animation_MoveX,
    Widget_Animation_MoveY,
    Widget_Animation_ImageShade,
    Widget_Animation_ImageFadeIn,
    Widget_Animation_FadeIn,
}WidgetType;




@interface SwipeDataSource : NSObject{
    NSMutableDictionary *json_datas;
}
@property (nonatomic) int currentCatagory;

-(int) getPageCount;
-(id)  getPage:(NSString*)pageName;
-(id)  getWidgetInPage:(NSString*)widgetName InPage:(NSString*)pageName;
-(NSString*) getPageFileNameByIndex:(int)index;

+(WidgetType) widgetTypeFromDict:(NSDictionary*)dict;
+(SwipeDataSource*) instance;
@end





