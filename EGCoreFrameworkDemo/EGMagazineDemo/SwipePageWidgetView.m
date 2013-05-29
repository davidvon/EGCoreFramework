//
//  SwipePageWidgetView.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-28.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipePageWidgetView.h"

@implementation SwipePageWidgetView
@synthesize imageview, destination;

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)image toDestination:(CGPoint)point
{
    self = [super initWithFrame:frame];
    if (self) {
        imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        [self addSubview:imageview];
        destination = point;
    }
    return self;
}


- (void)swipeViewDidScroll:(float)offset withIndex:(int) index
{
    CGRect rect = self.frame;
    float val = offset - index;
    rect.origin.x = destination.x - val*1000;
    NSLog(@"offset=%f, index=%d, result=%f, destX=%d, currentX=%d",offset, index, val, (int)destination.x, (int)rect.origin.x);
    self.frame = rect;
}



@end
