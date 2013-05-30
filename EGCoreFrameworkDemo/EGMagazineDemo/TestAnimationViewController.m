//
//  DemoViewController.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "TestAnimationViewController.h"
#import <UIKit/UIKit.h>
#import "EGCore/EGBasicAnimation.h"
#import "EGCore/EGReflection.h"

@implementation TestAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self reflectionShow];
//    [self animationShow];
//    [self initAnimationBackground];
//    [self timerAnimation];
    [self bazierAnimation];
}


//============================================================================
// BAZIER ANIMATION
//============================================================================
-(void)bazierAnimation
{
    CAKeyframeAnimation *anim = [EGBasicAnimation movePathBySVG:self.view durcation:5.f bySVGFile:@"BezierCurve1"];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(100,100,120,130)];
    iv.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:iv];
    [iv.layer addAnimation:anim forKey:nil];
}



//============================================================================
// TIMER ANIMATION BY NONE THREAD
//============================================================================

-(void) animationShow
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(130,130,100,100)];
    imageview.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:imageview];
    CABasicAnimation *anim = [EGBasicAnimation opacityForever_Animation:3.f];
    UIView *view = [[self.view subviews] lastObject];
    [view.layer addAnimation:anim forKey:nil];
}



//============================================================================
// TIMER ANIMATION BY THREAD
//============================================================================
-(void)timerAnimation
{
    [NSTimer scheduledTimerWithTimeInterval:(1) target:self selector:@selector(animationShowByThread) userInfo:nil repeats:NO];
}

-(void) animationShowByThread
{
    [NSThread detachNewThreadSelector:@selector(animationGroupShow) toTarget:self withObject:nil];
}

-(UIImageView*) addImageView:(NSString*)imageName withFrame:(CGRect)frame
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.image = [UIImage imageNamed:imageName];
    [self.view addSubview:imageview];
    return imageview;
}

-(void) animationGroupShow
{
    UIImageView *imageview = [self addImageView:@"XSW_vacation_Golf_small_back" withFrame:CGRectMake(-681,200,681,70)];
    CABasicAnimation *anim = [EGBasicAnimation moveX:0.3f X:[NSNumber numberWithInt:680]];
    [imageview.layer addAnimation:anim forKey:nil];

    imageview = [self addImageView:@"XSW_vacation_Golf_small_writing" withFrame:CGRectMake(-501,210,373,51)];
    [imageview.layer addAnimation:anim forKey:nil];
    
    imageview = [self addImageView:@"XSW_vacation_Golf_big_back" withFrame:CGRectMake(1024,280,722,109)];
    [EGBasicAnimation moveX:300 duration:0.4f delay:0.5f withView:imageview ];

    imageview = [self addImageView:@"XSW_vacation_Golf_big_writing" withFrame:CGRectMake(1024,290,650,76)];
    [EGBasicAnimation moveX:340 duration:0.4f  delay:0.5f withView:imageview ];
}



//============================================================================
// BACKGROUND ANIMATION
//============================================================================
-(void)initAnimationBackground
{
    KenBurnsView *kenView = [[KenBurnsView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
    [self.view addSubview:kenView];
    kenView.layer.borderWidth = 1;
    kenView.layer.borderColor = [UIColor blackColor].CGColor;
    NSArray *myImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"XSW_vacation_big_view_3.jpg"], nil];
    [kenView animateWithImages:myImages transitionDuration:60 loop:YES isLandscape:YES];
}



//============================================================================
// REFLECTION
//============================================================================
-(void) reflectionFunction
{
    NSLog(@"reflectionFunction....");
}

@end
