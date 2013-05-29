//
//  TestReflectionView.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-29.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestReflection.h"
#import "EGCore/EGReflection.h"

@implementation TestReflection

- (id)init
{
    self = [super init];
    if (self) {
        [self reflectionShow];
    }
    return self;
}


-(void)reflectionShow
{
    [EGReflection performSelector:@"reflectionFunction" ofClass:@"TestAnimationViewController" withParam:nil];
}

@end
