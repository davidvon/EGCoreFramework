//
//  SwipePageView.m
//
//  Created by feng guanhua on 13-5-5.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SwipePageView.h"
#import "SwipePageWidgetView.h"


@implementation SwipePageView
@synthesize pos, swipeWidgets, animationWidgets;

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 1024, 768);
        swipeWidgets = [[NSMutableArray alloc] init];
        kenView = [[KenBurnsView alloc] initWithFrame:CGRectMake(0,0,1024,768)];
        animationWidgets = [[NSMutableArray alloc] init];
        [self addSubview:kenView];        
    }
    return self;
}



#define INVALID_POS_X 4000
-(void) resetContentWithIndex:(int)index
{
    for( int i=0; i<swipeWidgets.count; i++){
        SwipePageWidgetView *view = [swipeWidgets objectAtIndex:i];
        [view removeFromSuperview];
    }
    [swipeWidgets removeAllObjects];
    
    NSString *name = [NSString stringWithFormat:@"wzall%d", index];
    WidgetParams *params = [[WidgetParams alloc] initWithParams:CGRectMake(INVALID_POS_X, 100, 435, 121) destX:589 image:name durnation:0 delay:0];
    SwipePageWidgetView *widget = [[SwipePageWidgetView alloc] initWithParams:params ofType:WIDGET_SWIPING];
    [swipeWidgets addObject:widget];
    [self addSubview:widget];
    
    name = [NSString stringWithFormat:@"wzall%d", 2];
    params = [[WidgetParams alloc] initWithParams:CGRectMake(INVALID_POS_X, 300, 435, 121) destX:10 image:name durnation:0 delay:0];
    widget = [[SwipePageWidgetView alloc] initWithParams:params ofType:WIDGET_SWIPING];
    [swipeWidgets addObject:widget];
    [self addSubview:widget];
    
    [self initAnimationBackground:index];
}




- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    for ( int i=0;  i<swipeWidgets.count; i++ ) {
        SwipePageWidgetView *view = [swipeWidgets objectAtIndex:i];
        [view swipeViewDidScroll:[swipeView scrollOffset] withIndex:[swipeView previousItemIndex]];
    }
}

- (void)swipeViewDidEndDragging:(SwipeView *)swipeView
{
    [self timerAnimation:0.3f];
}


-(void)timerAnimation:(float)delay
{
    [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(animateAllWidgets) userInfo:nil repeats:NO];
}


-(void)animateAllWidgets
{
    for( int i=0; i<animationWidgets.count; i++){
        UIView *view = [animationWidgets objectAtIndex:i];
        [view removeFromSuperview];
    }
    [animationWidgets removeAllObjects];
    
    [self addWidgetsInPage];
    
    for( int i=0; i<animationWidgets.count; i++){
        UIView *view = [animationWidgets objectAtIndex:i];
        [(SwipePageWidgetView*)view animate];
    }
    
}


-(void) addWidgetsInPage
{
    WidgetParams *params = [[WidgetParams alloc] initWithParams:CGRectMake(-681,200,681,70) destX:680 image:@"XSW_vacation_Golf_small_back" durnation:0.6 delay:1];
    SwipePageWidgetView *widget = [[SwipePageWidgetView alloc] initWithParams:params ofType:WIDGET_ANIMATION ];
    [animationWidgets addObject:widget];
    
    params = [[WidgetParams alloc] initWithParams:CGRectMake(-501,210,373,51) destX:680 image:@"XSW_vacation_Golf_small_writing" durnation:0.6 delay:1];
    widget = [[SwipePageWidgetView alloc] initWithParams:params ofType:WIDGET_ANIMATION];
    [animationWidgets addObject:widget];

    params = [[WidgetParams alloc] initWithParams:CGRectMake(1024,280,722,109) destX:300 image:@"XSW_vacation_Golf_big_back" durnation:0.4f delay:0.5f];
    widget = [[SwipePageWidgetView alloc] initWithParams:params ofType:WIDGET_ANIMATION];
    [animationWidgets addObject:widget];
    
    params = [[WidgetParams alloc] initWithParams:CGRectMake(1024,290,650,76) destX:340 image:@"XSW_vacation_Golf_big_writing" durnation:0.4f delay:0.5f];
    widget = [[SwipePageWidgetView alloc] initWithParams:params ofType:WIDGET_ANIMATION];
    [animationWidgets addObject:widget];
}


-(void)initAnimationBackground:(int)index
{
    NSString *name = [NSString stringWithFormat:@"bg%d.jpg", index];
    NSArray *myImages = [NSArray arrayWithObjects:[UIImage imageNamed:name], nil];
    [kenView animateWithImages:myImages transitionDuration:60 loop:YES isLandscape:YES];    
}

@end
