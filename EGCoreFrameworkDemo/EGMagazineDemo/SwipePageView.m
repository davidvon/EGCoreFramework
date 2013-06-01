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
#import "Constant.h"


@implementation SwipePageView
@synthesize widgets,json_data;

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
    [self loadSwipingWidgets:index];
    
    [self initAnimationBackground:index];
    [self timerAnimation];
}



-(void)loadSwipingWidgets:(int)index
{
    NSString *pageName = [NSString stringWithFormat:@"page2_%d.json", index];
    json_data = [AppJsonDataSource getPage:pageName];
    
    NSArray *objs = [json_data objectForKey:@"widget.swipings"];
    for ( int i=0 ; i<[objs count]; i++ ) {
        NSDictionary *obj = [objs objectAtIndex:i];
        SwipePageWidgetView *widget = [SwipePageWidgetView initWithJsonDict:obj inView:self];
        [widgets addObject:widget];
    }
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



-(void) animationGroupShow
{
    NSArray *objs = [json_data objectForKey:@"widget.animations"];
    for ( int i=0 ; i<[objs count]; i++ ) {
        NSDictionary *obj = [objs objectAtIndex:i];
        SwipePageWidgetView *widget = [SwipePageWidgetView initWithJsonDict:obj inView:self];
        [widgets addObject:widget];
    }
}


-(void)initAnimationBackground:(int)index
{
    NSString *name = [NSString stringWithFormat:@"bg%d.jpg", index];
    NSArray *myImages = [NSArray arrayWithObjects:[UIImage imageNamed:name], nil];
    [kenView animateWithImages:myImages transitionDuration:60 loop:YES isLandscape:YES];
}

@end



