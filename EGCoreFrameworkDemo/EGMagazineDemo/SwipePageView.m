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
#import "AppDataSource.h"


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
    [self loadStaticShowWidgets:index forKey:D_WIDGET_STATIC_IMAGE];
    [self loadStaticShowWidgets:index forKey:D_WIDGET_SWIPINGS];
    [self initAnimationBackground:json_data];    
    [self timerAnimation];
}



-(void)loadStaticShowWidgets:(int)index forKey:(NSString*)key
{
    NSString *pageName = [[AppDataSource instance] getPageFileNameByIndex:index];
    if( pageName.length == 0 ) return;
    NSString *filename = [pageName stringByAppendingString:@".json"];
    NSLog(@"name=%@", filename);
    
    json_data = [[AppDataSource instance] getPage:filename];
    
    NSArray *objs = [json_data objectForKey:key];
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
    NSArray *objs = [json_data objectForKey:D_WIDGET_ANIMATIONS];
    for ( int i=0 ; i<[objs count]; i++ ) {
        NSDictionary *obj = [objs objectAtIndex:i];
        SwipePageWidgetView *widget = [SwipePageWidgetView initWithJsonDict:obj inView:self];
        [widgets addObject:widget];
    }
}


-(void)initAnimationBackground:(NSDictionary*)dict
{
    NSString *bg = [dict objectForKey:@"background"];
    NSArray *myImages = [NSArray arrayWithObjects:[UIImage imageNamed:bg], nil];
    [kenView animateWithImages:myImages transitionDuration:60 loop:YES isLandscape:YES];
}

@end



