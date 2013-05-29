//
//  SwipePageWidgetView.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-28.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipePageWidgetView : UIView

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic) CGPoint destination;

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)image toDestination:(CGPoint)point;
- (void)swipeViewDidScroll:(float)offset withIndex:(int) index;

@end
