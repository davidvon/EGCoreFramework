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


@interface WidgetImage: NSObject
@property (nonatomic, strong) NSString *image;
@property (nonatomic) CGRect frame;
@end

@interface WidgetParams: NSObject
@property (nonatomic, strong) NSArray *imagelist;
@property (nonatomic) float durnation;
@property (nonatomic) float delay;
@property (nonatomic) int destinationX;

-(id) initWithParams:(CGRect)rect destX:(int)x image:(NSString*)name durnation:(float)dur delay:(float)del;
-(id) initWithParams:(NSArray*)images destX:(int)x durnation:(float)dur delay:(float)del;
@end




@interface SwipePageWidgetView : UIView{
    WidgetType widgetType;
}
@property (nonatomic, strong) NSMutableArray *imageViewLists;
@property (nonatomic) int   destinationX;
@property (nonatomic) float durnation;
@property (nonatomic) float delay;

- (id)initWithParams:(WidgetParams*)params withFrame:(CGRect)frame ofType:(WidgetType)type;
- (void)swipeViewDidScroll:(float)offset withIndex:(int) index;
@end

