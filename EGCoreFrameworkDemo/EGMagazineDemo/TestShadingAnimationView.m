//
//  TestEGShadingAnimationView.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-6-3.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "TestShadingAnimationView.h"
#import "EGCore/EGShadingImageView.h"
@implementation TestShadingAnimationView

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    EGShadingImageView *imgView = [[EGShadingImageView alloc] initWithBackgroundImage:(NSString*)@"XSW_vacation_Golf_big_back" withPoint:CGPointMake( 20, 20) ];
    [self.view addSubview:imgView];
    
    [imgView addAnimationImage:@"XSW_vacation_Golf_big_writing" withStyle:kCAGravityBottom fromPoint:CGPointMake(20, 10)];
}


@end
