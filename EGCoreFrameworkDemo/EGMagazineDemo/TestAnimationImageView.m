//
//  TestEGShadingAnimationView.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-6-3.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "TestAnimationImageView.h"
#import "EGCore/EGAnimateImageView.h"
#import "EGCore/SwipePageDataSource.h"

@implementation TestAnimationImageView

-(id) initWithType:(int) type
{
    self = [super init];
    animationType = type;
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    EGAnimateImageView *imgView = [[EGAnimateImageView alloc] initWithBackgroundImage:(NSString*)@"XSW_vacation_Golf_big_back" withPoint:CGPointMake( 20, 20) ];
    [self.view addSubview:imgView];
    [imgView addAnimationImage:@"XSW_vacation_Golf_big_writing" withType:animationType fromPoint:CGPointMake(20, 10)];
    [imgView animate];
}


@end
