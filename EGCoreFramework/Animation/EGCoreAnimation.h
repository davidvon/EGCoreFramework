//
//  EGCoreAnimation.h
//  EGCoreFramework
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface EGCoreAnimation : NSObject

//纵横移动
+(CABasicAnimation *) moveX:(float)duration X:(NSNumber *)x;
+(CABasicAnimation *) moveY:(float)duration Y:(NSNumber *)y;
+(void) moveX:(int)x duration:(float)duration delay:(float)time inView:(UIView *)view;
+(void) moveY:(int)y duration:(float)duration delay:(float)time inView:(UIView *)view;
+(void) moveLoopX:(float)dur from:(int)fromX to:(int)toX inView:(UIView *)view;
+(void) moveLoopY:(float)dur from:(int)fromY to:(int)toY inView:(UIView *)view;
+(CABasicAnimation *) movePoint:(CGPoint )point;

//路径动画
+(CAKeyframeAnimation*) movePathBySVG:(UIView*)owner durcation:(float)dur bySVGFile:(NSString*)svg;
+(CAKeyframeAnimation*) keyPath:(CGMutablePathRef)path durTimes:(float)time repeatTimes:(float)repeatTimes;

//永久闪烁
+(CABasicAnimation*) opacityForever:(float)time;
+(void) opacityTimes:(float)repeatTimes durTimes:(float)time inView:(UIView *)view;

//缩放
+(CABasicAnimation*) scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes;

//组合动画
+(CAAnimationGroup*) groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes;

//旋转
+(CABasicAnimation*) rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount;
+(void) rotationWithImageView:(UIImageView*)view durcation:(float)dur repeatCount:(int)repeatCount;
+(void) rotationWithImageView:(UIImageView*)view durcation:(float)dur repeatCount:(int)repeatCount direction:(int)dir;

//褪色
+(void) fadeIn:(float)duration delay:(float)time inView:(UIView *)view;
@end





