//
//  EGShadingImageView.m
//  EGCoreFramework
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "EGShadingImageView.h"

@implementation EGShadingImageView

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


-(void)addAnimationImage:(NSString*)name withStyle:(NSString*)style fromPoint:(CGPoint)point;
{
    if(animateLayer){
        [animateLayer removeFromSuperlayer];
        animateLayer = nil;
    }
    animateLayer = [CALayer layer];
    animateLayer.frame = CGRectMake(point.x, point.y, self.frame.size.width, currentHeight);
    UIImage *image = [UIImage imageNamed:name];
    animateLayer.contents= (id)image.CGImage;
    animateLayer.masksToBounds = YES;
    animateLayer.contentsGravity = style;
    [self.layer addSublayer:animateLayer];
    currentHeight = self.frame.origin.y;
}


-(void)stepHeight
{
    currentHeight += 2;
    animateLayer.frame = CGRectMake(animateLayer.frame.origin.x, animateLayer.frame.origin.y, self.frame.size.width, currentHeight);
//    NSLog(@"current=%d, y=%f, end=%f", currentHeight, self.frame.origin.y, self.frame.size.height );
    if (currentHeight >= self.frame.size.height) {
        if(timer)[timer invalidate];
        timer = nil;
        currentHeight=0;
    }
}

-(void) animate
{
    if(timer){
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(stepHeight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

@end
