//
//  AnimateImageWidgetView.m
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-4.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "AnimateImageWidgetView.h"
#import "EGAnimateImageView.h"

@implementation AnimateImageWidgetView
@synthesize animateView;

- (id)initWithJsonDict:(NSDictionary *)dict withType:(WidgetType)type
{
    NSArray *pos = [dict objectForKey:@"image.position"];
    int x =  [[pos objectAtIndex:0] intValue];
    int y =  [[pos objectAtIndex:1] intValue];
    UIImage *image = [UIImage imageNamed: [dict objectForKey:@"image"]];
    CGRect ret = CGRectMake( x, y, image.size.width, image.size.height);
    self = [super initWithFrame:ret];
    widgetType = type;
    animateView = [[EGAnimateImageView alloc] initWithBackgroundImage:[dict objectForKey:@"image"] withPoint:CGPointMake(x,y) ];
    [self addSubview:animateView];
    
    NSString *animateImage = [dict objectForKey:@"animation.image"];
    pos = [dict objectForKey:@"animation.position"];
    x =  [[pos objectAtIndex:0] intValue];
    y =  [[pos objectAtIndex:1] intValue];
    if([dict objectForKey:@"delay"]) delay = [[dict objectForKey:@"delay"] floatValue];
    
    [animateView addAnimationImage:animateImage withType:widgetType fromPoint:CGPointMake(x, y)];
  
    return self;
}



-(void) animate
{
    [animateView animate];
}



@end
