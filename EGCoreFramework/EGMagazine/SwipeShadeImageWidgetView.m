//
//  SwipePageWidgetView_ImageShading.m
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-4.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipeShadeImageWidgetView.h"

@implementation SwipeShadeImageWidgetView
@synthesize imageview;

- (id)initWithJsonDict:(NSDictionary *)dict
{
    NSArray *pos = [dict objectForKey:@"image.position"];
    int x =  [[pos objectAtIndex:0] intValue];
    int y =  [[pos objectAtIndex:1] intValue];
    UIImage *image = [UIImage imageNamed: [dict objectForKey:@"image"]];
    CGRect ret = CGRectMake( x, y, image.size.width, image.size.height);
    self = [super initWithFrame:ret];

    imageview = [[EGShadingImageView alloc] initWithBackgroundImage:[dict objectForKey:@"image"] withPoint:CGPointMake(x,y) ];
    [self addSubview:imageview];
    
    NSString *animateImage = [dict objectForKey:@"animation.image"];
    pos = [dict objectForKey:@"animation.position"];
    x =  [[pos objectAtIndex:0] intValue];
    y =  [[pos objectAtIndex:1] intValue];

    [imageview addAnimationImage:animateImage withStyle:kCAGravityBottom fromPoint:CGPointMake(x, y)];
    if([dict objectForKey:@"delay"]) delay = [[dict objectForKey:@"delay"] floatValue];    
    return self;
}



-(void) animate
{
    [imageview animate];    
}



@end
