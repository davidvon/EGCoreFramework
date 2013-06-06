//
//  AnimateImageWidgetView.h
//  EGCoreFramework
//
//  Created by feng guanhua on 13-6-4.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "AnimateWidgetView.h"
#import "EGAnimateImageView.h"

@interface AnimateImageWidgetView : AnimateWidgetView

@property(nonatomic,strong) EGAnimateImageView *animateView;

- (id)initWithJsonDict:(NSDictionary *)dict withType:(WidgetType)type;
-(void) animate;

@end
