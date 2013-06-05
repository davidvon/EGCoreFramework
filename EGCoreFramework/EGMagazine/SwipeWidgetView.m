//
//  SwipePageWidgetView.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-28.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipeWidgetView.h"
#import "EGCoreAnimation.h"
#import "EGReflection.h"
#import "Constant.h"

@implementation SwipeWidgetView
@synthesize reflectionInfo;

- (id)initWithParams:(CGRect)widgetFrame dest:(int)xy image:(NSString*)name durnation:(float)dur delay:(float)del withMainViewFrame:(CGRect)mainFrame ofType:(WidgetType)wtype
{
    self = [super initWithFrame:mainFrame];
    if (self) {
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imageview.frame = widgetFrame;
        [self addSubview:imageview];
        widgetType = wtype;
        destination = xy;
        duration = dur;
        delay = del;
    }
    return self;
}


-(BOOL) addImagePerfrom:(NSString*)image withFrame:(CGRect)frame withDict:(NSDictionary *)dict
{
    reflectionInfo = [dict objectForKey:@"perform"];
    if( !reflectionInfo ) return FALSE;
    UIButton *button = [Constant addButton:frame withImage:image inView:self];
    [button addTarget:self action:@selector(reflection) forControlEvents:UIControlEventTouchUpInside];
    return TRUE;
}



-(void) reflection
{
    NSString *class = [reflectionInfo objectForKey:@"class"];
    NSString *func  = [reflectionInfo objectForKey:@"function"];
    NSDictionary *param = [reflectionInfo objectForKey:@"parameters"];
    [EGReflection performSelector:func ofClass:class withParam:param];
}



- (void)toDestination:(NSDictionary *)to
{
    if( !to ) return;
    NSString *tox = [to objectForKey:@"x"];
    if( tox.length == 0 ){
        NSString *toy = [to objectForKey:@"y"];
        assert(toy.length > 0);
        destination = [toy integerValue];
    } else {
        destination = [tox integerValue];
    }
}



- (void)loadPosParamInJson:(NSDictionary *)dict
{
    NSString *image   = [dict objectForKey:@"image"];
    NSDictionary *pos = [dict objectForKey:@"position"];
    NSArray *from     = [pos objectForKey:@"from"];
    CGRect imageFrame = [SwipeWidgetView createCGRectByDict:from];
    bool isExist = [self addImagePerfrom:image withFrame:imageFrame withDict:dict];
    if( !isExist ) {
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        imageview.frame = imageFrame;
        [self addSubview:imageview];
    }    
    [self toDestination: [pos objectForKey:@"to"]];
}



- (id)initWithJsonDict:(NSDictionary *)dict
{
    CGRect ret = [SwipeWidgetView createCGRectByDict:[dict objectForKey:@"frame"]];
    self = [super initWithFrame:ret];
    self.name =  [dict objectForKey:@"name"];
    
    widgetType = [SwipeDataSource widgetTypeFromDict: dict];
    [self loadPosParamInJson:dict];
    if([dict objectForKey:@"duration"]) duration = [[dict objectForKey:@"duration"] floatValue];
    if([dict objectForKey:@"delay"])    delay    = [[dict objectForKey:@"delay"] floatValue];
    
    NSLog(@"name=%@", self.name);
    return self;
}



+(CGRect) createCGRectByDict:(NSArray*)dict
{
    NSInteger x =  [[dict objectAtIndex:0] integerValue];
    NSInteger y =  [[dict objectAtIndex:1] integerValue];
    NSInteger w =  [[dict objectAtIndex:2] integerValue];
    NSInteger h =  [[dict objectAtIndex:3] integerValue];
    return CGRectMake(x,y,w,h);
}



- (void)swipeViewDidScroll:(float)offset withIndex:(int) index
{
    if( widgetType == Widget_Swiping || widgetType ==  Widget_Animation_Swiping ){
        CGRect rect = self.frame;
        float val = offset - index;
        rect.origin.x = destination- val*1000;
        self.frame = rect;
    }
}


-(void) animate
{
    switch (widgetType) {
        case Widget_Animation_MoveX:
            return [EGCoreAnimation moveX:destination duration:duration delay:delay withView:self];
        case Widget_Animation_MoveY:
            return [EGCoreAnimation moveY:destination duration:duration delay:delay withView:self];
        default:
            return;
    }        
}


@end
