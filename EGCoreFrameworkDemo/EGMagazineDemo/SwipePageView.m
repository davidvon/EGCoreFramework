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
@synthesize pos, widgets;

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 1024, 768);
        widgets = [[NSMutableArray alloc] init];
        kenView = [[KenBurnsView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
        [self addSubview:kenView];
    }
    return self;
}


-(void) clearExistingWidgets
{
    for( int i=0; i<widgets.count; i++){
        SwipePageWidgetView *view = [widgets objectAtIndex:i];
        [view removeFromSuperview];
    }
    [widgets removeAllObjects];
}


-(void) resetContentWithIndex:(int)index
{    
    [self clearExistingWidgets];
    
    
    NSString *name = [NSString stringWithFormat:@"wzall%d", index];
    SwipePageWidgetView *widget = [self addWidgetView:CGRectMake(4000, 60, 435, 121) toDestX:-4000+1024-435 withImage:name durcation:0 delay:0 ofType:WIDGET_SWIPING withMainViewFrame:CGRectMake(0,0, 435, 121) inView:self];
    [widgets addObject:widget];
    
    name = [NSString stringWithFormat:@"wzall%d", 2];
    widget = [self addWidgetView:CGRectMake(-4000, 400, 435, 121) toDestX:4000 withImage:name durcation:0 delay:0 ofType:WIDGET_SWIPING withMainViewFrame:CGRectMake(0,0, 435, 121) inView:self];
    [widgets addObject:widget];
    
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
    [NSTimer scheduledTimerWithTimeInterval:(0.5) target:self selector:@selector(animationShowByThread) userInfo:nil repeats:NO];
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


-(SwipePageWidgetView*) addWidgetView:(CGRect)widgetFrame toDestX:(int)x withImage:(NSString*)image durcation:(float)dur delay:(float)time ofType:(WidgetType)type withMainViewFrame:(CGRect)mainFrame inView:(UIView *)view
{
    SwipePageWidgetView *widget = [[SwipePageWidgetView alloc] initWithParams:widgetFrame destX:x image:image durnation:dur delay:time withMainViewFrame:mainFrame ofType:type];
    [view addSubview:widget];
    return widget;
}


-(void) animationGroupShow
{
    SwipePageWidgetView *widget = [self addWidgetView:CGRectMake(-681,200,681,70) toDestX:681 withImage:@"XSW_vacation_Golf_small_back" durcation:0.4 delay:0.f ofType:WIDGET_ANIMATION withMainViewFrame:CGRectMake(-681,0,681,70) inView:self];
    [widgets addObject:widget];
    
    widget = [self addWidgetView:CGRectMake(-501,210,373,51) toDestX:680 withImage:@"XSW_vacation_Golf_small_writing" durcation:0.4f delay:0.05f  ofType:WIDGET_ANIMATION withMainViewFrame:CGRectMake(-501,0,373,51) inView:self];
    [widgets addObject:widget];
    
    widget = [self addWidgetView:CGRectMake(1024,280,722,109) toDestX:-722 withImage:@"XSW_vacation_Golf_big_back" durcation:0.5f delay:0.2f ofType:WIDGET_ANIMATION withMainViewFrame:CGRectMake(1024,0,722,109) inView:self];
    [widgets addObject:widget];

    widget = [self addWidgetView:CGRectMake(1024,290,650,76) toDestX:-670 withImage:@"XSW_vacation_Golf_big_writing" durcation:0.5f delay:0.25f  ofType:WIDGET_ANIMATION withMainViewFrame:CGRectMake(1024,0,650,76) inView:self];
    [widgets addObject:widget];
}


-(void)initAnimationBackground:(int)index
{
    NSString *name = [NSString stringWithFormat:@"bg%d.jpg", index];
    NSArray *myImages = [NSArray arrayWithObjects:[UIImage imageNamed:name], nil];
    [kenView animateWithImages:myImages transitionDuration:60 loop:YES isLandscape:YES];
}

@end



