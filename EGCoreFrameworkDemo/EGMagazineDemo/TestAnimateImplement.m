//
//  TestMainViewController.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-6-11.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "TestAnimateImplement.h"
#import "EGCore/EGCoreAnimation.h"
#import "EGCore/Constant.h"
@implementation TestAnimateImplement


-(void) mainPageAnimate:(SwipePageView*)page
{
    UIImageView *bigcloud = [Constant addImageView:CGRectMake(-520,0,1024,768) withImageName:@"big_yun" inView:page];
    CABasicAnimation *fadeIn = [EGCoreAnimation fade:6 from:0.1 to:1 ];
    CABasicAnimation *move2Right = [EGCoreAnimation moveX:30 X: [NSNumber numberWithInt:520]];
    NSArray *animates = [NSArray arrayWithObjects:fadeIn, move2Right, nil];
    CAAnimationGroup *animateGroup = [EGCoreAnimation groupAnimation:animates duration:30 repeats:100 autoreverse:TRUE];
    [bigcloud.layer addAnimation:animateGroup forKey:nil];

    UIImageView *smallcloud = [Constant addImageView:CGRectMake(200,480,469,284) withImageName:@"small_yun" inView:page];
    fadeIn = [EGCoreAnimation fade:6 from:0.1 to:1 ];
    move2Right = [EGCoreAnimation moveX:30 X: [NSNumber numberWithInt:520]];
    animates = [NSArray arrayWithObjects:fadeIn, move2Right, nil];
    animateGroup = [EGCoreAnimation groupAnimation:animates duration:30 repeats:100 autoreverse:TRUE];
    [smallcloud.layer addAnimation:animateGroup forKey:nil];    
}
@end        