//
//  EGShadingImageView.m
//  EGCoreFramework
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "EGAnimateImageView.h"
#import "EGCoreAnimation.h"

@implementation EGAnimateImageView

- (id)initWithBackgroundImage:(NSString*)name withPoint:(CGPoint)point;
{
    UIImage *image = [UIImage imageNamed:name];
    self = [super initWithFrame:CGRectMake(point.x, point.y, image.size.width, image.size.height)];
    if (self) {
        currentHeight = 0;
        [super setImage:image];
    }
    return self;
}


-(void) addAnimationImage:(NSString*)name withType:(WidgetType)type fromPoint:(CGPoint)point
{
    if(animateLayer){
        [animateLayer removeFromSuperlayer];
        animateLayer = nil;
    }
    animateLayer = [CALayer layer];
    UIImage *image = [UIImage imageNamed:name];
    animateLayer.contents= (id)image.CGImage;
    animateLayer.masksToBounds = YES;
    widgetType = type;
    if( widgetType == Widget_Animation_ImageShade ){
        animateLayer.contentsGravity = kCAGravityBottom;
        animateLayer.frame = CGRectMake(point.x, point.y, self.frame.size.width, currentHeight);
    }else{
        animateLayer.frame = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    }
    [self.layer addSublayer:animateLayer];
    currentHeight = self.frame.origin.y;
}


-(void)stepHeight
{
    currentHeight += 2;
    animateLayer.frame = CGRectMake(animateLayer.frame.origin.x, animateLayer.frame.origin.y, self.frame.size.width, currentHeight);
    if (currentHeight >= self.frame.size.height) {
        if(timer)[timer invalidate];
        timer = nil;
        currentHeight=0;
    }
}

-(void) swipeAnimate
{
    if(timer){
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(stepHeight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}



-(void) fadeInAnimate
{
    [EGCoreAnimation fadeIn:0.6f delay:0 inView:self];
}


-(void)animate
{
    if( widgetType == Widget_Animation_ImageShade){
        [self swipeAnimate];
    } else {
        [self fadeInAnimate];
    }
}

@end
