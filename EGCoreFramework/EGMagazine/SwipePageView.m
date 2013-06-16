//
//  SwipePageView.m
//
//  Created by feng guanhua on 13-5-5.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "EGCoreAnimation.h"
#import "EGReflection.h"
#import "SwipePageView.h"
#import "SwipePageDataSource.h"
#import "AnimateWidgetView.h"
#import "AnimateImageWidgetView.h"
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


-(void) clearExistingSubViews
{
    for( UIView *view in [self subviews] ){
        if( [view isKindOfClass:[KenBurnsView class]] ) continue;
        [view removeFromSuperview];
    }
    
    [widgets removeAllObjects];
    json_data = nil;
}


-(void) resetContentWithIndex:(int)index
{    
    [self clearExistingSubViews];
    [self loadStaticShowWidgets:index forKey:Category_Widget_StaticImage withJsonData:nil];
    [self loadStaticShowWidgets:index forKey:Category_Widget_Swipings withJsonData:json_data];
    [self initAnimationBackground:json_data];    
    [self timerAnimation];
}




-(AnimateWidgetView*) createViewWithJsonDict:(NSDictionary*)dict inView:(UIView*)view
{
    AnimateWidgetView *widget = nil;
    WidgetType type = [SwipePageDataSource widgetTypeFromDict:dict];
    if( type == Widget_Animation_ImageShade || type == Widget_Animation_ImageFadeIn ){
        widget = [[AnimateImageWidgetView alloc] initWithJsonDict:dict withType:type];
    } else {
        widget = [[AnimateWidgetView alloc] initWithJsonDict:dict];
    }
    [view addSubview:widget];
    return widget;
}


-(void)loadStaticShowWidgets:(int)index forKey:(NSString*)key withJsonData:(NSDictionary*)data
{
    if(!data){
        NSString *pageName = [[SwipePageDataSource instance] getPageFileNameByIndex:index];
        if( pageName.length == 0 ) return;
        NSString *filename = [pageName stringByAppendingString:@".json"];
        NSLog(@"name=%@", filename);
        data = [[SwipePageDataSource instance] getPage:filename];
        json_data = data;
    }
    
    NSArray *objs = [data objectForKey:key];
    for ( int i=0 ; i<[objs count]; i++ ) {
        NSDictionary *obj = [objs objectAtIndex:i];
        AnimateWidgetView *widget = [self createViewWithJsonDict:obj inView:self];
        [widgets addObject:widget];
    }
}




- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    for ( int i=0;  i<widgets.count; i++ ) {
        AnimateWidgetView *view = [widgets objectAtIndex:i];
        [view swipeViewDidScroll:[swipeView scrollOffset] withIndex:[swipeView previousItemIndex]];
    }
}



-(void)timerAnimation
{    
    [NSTimer scheduledTimerWithTimeInterval:(0.3) target:self selector:@selector(animation) userInfo:nil repeats:NO];
}


-(void) animation
{
    [self animationGroupShow];
    
    NSDictionary *content = [json_data valueForKey:@"widget.animations.perform"];
    if(!content) return;
    NSString *class = [content valueForKey:@"class"];
    NSString *function = [content valueForKey:@"function"];
    if( class.length >0 && function.length > 0) {
        [EGReflection performSelector:function ofClass:class withParam:self];
    }
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
    NSArray *objs = [json_data objectForKey:Category_Widget_Animations];
    for ( int i=0 ; i<[objs count]; i++ ) {
        NSDictionary *obj = [objs objectAtIndex:i];
        
        AnimateWidgetView *widget = [self createViewWithJsonDict:obj inView:self];
        [widgets addObject:widget];
        [widget animate];
    }
}


-(void)initAnimationBackground:(NSDictionary*)dict
{
    NSString *bg = [dict objectForKey:@"background"];
    NSNumber *enable = [dict objectForKey:@"background.animate.enable"];
    if( enable && [enable boolValue]==false ){
        [Constant addImageView:CGRectMake(0,0,1024,768) withImageName:bg inView:self];
        return;
    }
    
    NSArray *myImages = [NSArray arrayWithObjects:[UIImage imageNamed:bg], nil];
    [kenView animateWithImages:myImages transitionDuration:BACKGROUND_TRANS_DUR loop:YES isLandscape:YES];
}

@end



