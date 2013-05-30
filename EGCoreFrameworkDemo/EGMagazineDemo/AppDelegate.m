//
//  AppDelegate.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "AppDelegate.h"
#import "TestAnimationViewController.h"
#import "TestSwipeViewController.h"
#import "TestReflection.h"

@implementation AppDelegate
@synthesize rootViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [self testcase];
    
    return YES;
}

-(void) testcase
{
    rootViewController = [[TestSwipeViewController alloc] init];
//    rootViewController = [[TestAnimationViewController alloc] init];
//    rootViewController = [[TestReflectionView alloc] init];
    self.window.rootViewController = rootViewController;
}


@end
