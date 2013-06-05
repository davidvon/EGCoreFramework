//
//  EGCoreAnimation.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "EGCoreAnimation.h"
#import "PocketSVG.h"

@implementation EGCoreAnimation



//FadeIn
+(void) fadeIn:(float)duration delay:(float)time withView:(UIView *)view
{
    view.alpha = 0;
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut;
    [UIView animateWithDuration:duration delay:time options:options animations:^ {
        view.alpha = 1;
    } completion:nil];
}




//永久闪烁的动画
+(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.0];
    animation.autoreverses=YES;
    animation.duration=time;
    animation.repeatCount=FLT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}


//有闪烁次数的动画
+(CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    animation.toValue=[NSNumber numberWithFloat:0.4];
    animation.repeatCount=repeatTimes;
    animation.duration=time;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=YES;
    return  animation;
}



//延时横向移动
+(void) moveX:(int)x duration:(float)duration delay:(float)time withView:(UIView *)view
{
    UIViewAnimationOptions options = UIViewAnimationCurveLinear | UIViewAnimationOptionCurveEaseInOut;
    [UIView animateWithDuration:duration delay:time options:options animations:^ {
        CGRect frame = view.frame;
        frame.origin.x = x;
        view.frame = frame;
     } completion:nil];
}


//横向移动
+(CABasicAnimation *)moveX:(float)duration X:(NSNumber *)x
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue=x;
    animation.duration=duration;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}



//延时纵向移动
+(void) moveY:(int)y duration:(float)duration delay:(float)time withView:(UIView *)view
{
    UIViewAnimationOptions options = UIViewAnimationCurveLinear | UIViewAnimationOptionCurveEaseInOut;
    [UIView animateWithDuration:duration delay:time options:options animations:^ {
        CGRect frame = view.frame;
        frame.origin.y = y;
        view.frame = frame;
    } completion:nil];
}



//纵向移动
+(CABasicAnimation *)moveY:(float)duration Y:(NSNumber *)y 
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue=y;
    animation.duration=duration;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}


//根据SVG文件轨迹移动
+(CAKeyframeAnimation*) movePathBySVG:(UIView*)owner durcation:(float)dur bySVGFile:(NSString*)svg
{
    PocketSVG *vectorDrawing = [[PocketSVG alloc] initFromSVGFileNamed:svg];
    UIBezierPath *bezierPath = vectorDrawing.bezier;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anim.path = bezierPath.CGPath;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.duration = dur;
    return anim;
}



//缩放
+(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue=orginMultiple;
    animation.toValue=Multiple;
    animation.duration=time;
    animation.autoreverses=YES;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}



//组合动画
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes
{
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    animation.animations=animationAry;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}



//路径动画
+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes
{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path=path;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses=NO;
    animation.duration=time;
    animation.repeatCount=repeatTimes;
    return animation;
}



//点移动
+(CABasicAnimation *)movepoint:(CGPoint )point 
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    return animation;
}



//旋转
+(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount 
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= dur;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    animation.delegate= self;
    return animation;
}



//旋转
+(void)rotationWithImageView:(UIImageView*)view durcation:(float)dur repeatCount:(int)repeatCount 
{
    //图片旋转360度
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI, 0, 0, 1.0) ];
    animation.duration = dur;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = repeatCount;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [view.image drawInRect:CGRectMake(1,1,view.frame.size.width-2,view.frame.size.height-2)];
    view.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [view.layer addAnimation:animation forKey:nil];
}



//旋转
+(void)rotationWithImageView:(UIImageView*)view durcation:(float)dur repeatCount:(int)repeatCount direction:(int)dir
{
    CGPoint fromPoint = view.center;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(fromPoint.x +100 , fromPoint.y ) ;
    [movePath addLineToPoint:toPoint];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    
    CABasicAnimation *TransformAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    TransformAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];

    if( dir == 1){ //X
        TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,1.0,0,0)];
    } else if(dir == 2) {  //Y
        TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,1.0,0)];
    } else {    //Z
        TransformAnim.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI,0,0,1.0)];
    }
    TransformAnim.cumulative = YES;
    TransformAnim.duration =dur;
    TransformAnim.repeatCount =repeatCount;
    view.center = toPoint;
    TransformAnim.removedOnCompletion = YES;
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, TransformAnim, nil];
    animGroup.duration = 6;
    [view.layer addAnimation:animGroup forKey:nil];
}


@end



