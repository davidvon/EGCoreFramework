//
//  EGShadingImageView.h
//  EGCoreFramework
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SwipePageDataSource.h"

@interface EGAnimateImageView : UIImageView
{
    int currentHeight;
    NSTimer *timer;
    CALayer *animateLayer;
    WidgetType  widgetType;
}

-(id) initWithBackgroundImage:(NSString*)name withPoint:(CGPoint)point;
-(void) addAnimationImage:(NSString*)name withType:(WidgetType)type fromPoint:(CGPoint)point;
-(void) animate;
@end
