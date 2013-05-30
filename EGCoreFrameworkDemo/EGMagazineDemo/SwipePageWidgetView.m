//
//  SwipePageWidgetView.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-28.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipePageWidgetView.h"
#import "EGCore/EGBasicAnimation.h"

@implementation WidgetParams
@synthesize imageName, frame, durnation, destinationX, delay;
-(id) initWithParams:(CGRect)rect destX:(int)x image:(NSString*)name durnation:(float)dur delay:(float)del
{
    self = [super init];
    self.frame = rect;
    self.destinationX = x;
    self.imageName = name;
    self.durnation = dur;
    self.delay = del;
    return self;
}
@end


@implementation SwipePageWidgetView
@synthesize imageview, inparams;

- (id)initWithParams:(WidgetParams*)params ofType:(WidgetType)type
{
    self = [super init];
    if (self) {
        inparams = params;
        self.frame = params.frame;
        imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:params.imageName]];
        [self addSubview:imageview];
        widgetType = type;
    }
    return self;
}


- (void)swipeViewDidScroll:(float)offset withIndex:(int) index
{
    CGRect rect = self.frame;
    float val = offset - index;
    rect.origin.x = inparams.destinationX- val*1000;
//    NSLog(@"self=%@, offset=%f, index=%d, result=%f, destX=%d, currentX=%d", self, offset, index, val, (int)inparams.destinationX, (int)rect.origin.x);
    self.frame = rect;
}


-(void) animate
{
    [NSThread detachNewThreadSelector:@selector(animateByThread) toTarget:self withObject:nil];
}


-(void) animateByThread
{
    [EGBasicAnimation moveX:inparams.destinationX duration:inparams.durnation delay:inparams.delay withView:self];
}


@end
