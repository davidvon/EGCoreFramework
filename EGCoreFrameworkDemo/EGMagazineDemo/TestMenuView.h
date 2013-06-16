//
//  TestMenuView.h
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-6-11.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestMenuView : UIView{
    BOOL isShow;
    int  currentTag;
}
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *selectedItem;
@property (nonatomic, strong) UIViewController *mainDelegate;
@end
