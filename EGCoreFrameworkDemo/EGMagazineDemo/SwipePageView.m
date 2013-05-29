//
//  SwipePageView.m
//
//  Created by feng guanhua on 13-5-5.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SwipePageView.h"
#import "SwipePageWidgetView.h"
#import "EGCore/EGBasicAnimation.h"
#define INVALID_POS_X 4000


@implementation SwipePageView
@synthesize pos, widgets, animationImages;

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 1024, 768);
        widgets = [[NSMutableArray alloc] init];
        kenView = [[KenBurnsView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
        animationImages = [[NSMutableArray alloc] init];
        [self addSubview:kenView];        
    }
    return self;
}



-(void) resetContentWithIndex:(int)index
{
    for( int i=0; i<widgets.count; i++){
        SwipePageWidgetView *view = [widgets objectAtIndex:i];
        [view removeFromSuperview];
    }
    [widgets removeAllObjects];
    
    int x = (index==1)?589:INVALID_POS_X;
    NSString *name = [NSString stringWithFormat:@"wzall%d", index];
    CGPoint point = {589,100};
    SwipePageWidgetView *widget = [[SwipePageWidgetView alloc] initWithFrame:CGRectMake(x,100, 435, 121) withImageName:name toDestination:point];
    [widgets addObject:widget];
    [self addSubview:widget];
    
    x = (index==1)?10:INVALID_POS_X;
    name = [NSString stringWithFormat:@"wzall%d", 2];
    point.x = 10;
    widget = [[SwipePageWidgetView alloc] initWithFrame:CGRectMake(x,300, 435, 121) withImageName:name toDestination:point];
    [widgets addObject:widget];
    [self addSubview:widget];
        
    [self initAnimationBackground:index];
    [self timerAnimation];    
}




- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    for ( int i=0;  i<widgets.count; i++ ) {
        SwipePageWidgetView *view = [widgets objectAtIndex:i];
        [view swipeViewDidScroll:[swipeView scrollOffset] withIndex:[swipeView previousItemIndex]];
    }
}




-(void)timerAnimation
{
    for( int i=0; i<animationImages.count; i++){
        UIView *view = [animationImages objectAtIndex:i];
        [view removeFromSuperview];
    }
    [animationImages removeAllObjects];
    
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
    [self addSubview:imageview];
    return imageview;
}


-(void) animationGroupShow
{    
    UIImageView *imageview = [self addImageView:@"XSW_vacation_Golf_small_back" withFrame:CGRectMake(-681,200,681,70)];
    CABasicAnimation *anim = [EGBasicAnimation moveX:0.3f X:[NSNumber numberWithInt:680]];
    [imageview.layer addAnimation:anim forKey:nil];
    
    UIImageView *imageview2 = [self addImageView:@"XSW_vacation_Golf_small_writing" withFrame:CGRectMake(-501,210,373,51)];
    [imageview2.layer addAnimation:anim forKey:nil];
    
    UIImageView *imageview3 = [self addImageView:@"XSW_vacation_Golf_big_back" withFrame:CGRectMake(1024,280,722,109)];
    [EGBasicAnimation moveX:0.4f X:[NSNumber numberWithInt:300] delay:0.5f withView:imageview3];
    
    UIImageView *imageview4 = [self addImageView:@"XSW_vacation_Golf_big_writing" withFrame:CGRectMake(1024,290,650,76)];
    [EGBasicAnimation moveX:0.4f X:[NSNumber numberWithInt:340] delay:0.5f withView:imageview4 ];
    [animationImages addObject:imageview];
    [animationImages addObject:imageview2];
    [animationImages addObject:imageview3];
    [animationImages addObject:imageview4];
}


-(void)initAnimationBackground:(int)index
{
    NSString *name = [NSString stringWithFormat:@"bg%d.jpg", index];
    NSArray *myImages = [NSArray arrayWithObjects:[UIImage imageNamed:name], nil];
    [kenView animateWithImages:myImages transitionDuration:60 loop:YES isLandscape:YES];    
}

@end
