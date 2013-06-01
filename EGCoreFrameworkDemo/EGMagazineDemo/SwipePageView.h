//
//  SwipePageView.h
//  DishOrder
//
//  Created by feng guanhua on 13-5-5.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGCore/SwipeView.h"
#import "EGCore/JBKenBurnsView.h"

@interface SwipePageView : UIView{
    KenBurnsView *kenView;
}

@property (nonatomic) int pos;
@property (nonatomic, strong) NSMutableArray *widgets;

- (void) resetContentWithIndex:(int)index;
- (void) swipeViewDidScroll:(SwipeView *)swipeView;

@end


