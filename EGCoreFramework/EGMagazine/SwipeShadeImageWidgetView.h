//
//  SwipeShadeImageWidgetView.h
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-4.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipeWidgetView.h"
#import "EGShadingImageView.h"

@interface SwipeShadeImageWidgetView : SwipeWidgetView
@property(nonatomic,strong) EGShadingImageView *imageview;

- (id)initWithJsonDict:(NSDictionary *)dict;
-(void) animate;
@end
