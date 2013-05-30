//
//  SwipePageWidgetView.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-28.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WIDGET_SWIPING,
    WIDGET_ANIMATION,
}WidgetType;



@interface WidgetParams: NSObject
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic) CGRect frame;
@property (nonatomic) float durnation;
@property (nonatomic) float delay;
@property (nonatomic) int destinationX;

-(id) initWithParams:(CGRect)rect destX:(int)x image:(NSString*)name durnation:(float)dur delay:(float)delay;

@end




@interface SwipePageWidgetView : UIView{
    WidgetType widgetType;
}
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) WidgetParams *inparams;

- (id)initWithParams:(WidgetParams*)params ofType:(WidgetType)type;
- (void)swipeViewDidScroll:(float)offset withIndex:(int) index;
-(void)animate;
@end
