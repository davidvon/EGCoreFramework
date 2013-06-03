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

+(CABasicAnimation *)moveX:(float)duration X:(NSNumber *)x;     //横向移动
+(CABasicAnimation *)moveY:(float)duration Y:(NSNumber *)y;     //纵向移动
+(void) moveX:(int)x duration:(float)duration delay:(float)time withView:(UIView *)view;
+(void) moveY:(int)y duration:(float)duration delay:(float)time withView:(UIView *)view;
+(CAKeyframeAnimation*) movePathBySVG:(UIView*)owner durcation:(float)dur bySVGFile:(NSString*)svg;

+(CABasicAnimation *)opacityForever_Animation:(float)time;  //永久闪烁的动画
+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;

+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes; //缩放
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes;        //组合动画
+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes;   //路径动画
+(CABasicAnimation *)movepoint:(CGPoint )point;             //点移动
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount;  //旋转

+(void)rotationWithImageView:(UIImageView*)view durcation:(float)dur repeatCount:(int)repeatCount;
+(void)rotationWithImageView:(UIImageView*)view durcation:(float)dur repeatCount:(int)repeatCount direction:(int)dir; //旋转


@end
