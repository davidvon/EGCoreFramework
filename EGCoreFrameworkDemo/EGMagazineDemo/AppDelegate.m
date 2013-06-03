//
//  AppDelegate.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-26.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "AppDelegate.h"
#import "TestCoreAnimationView.h"
#import "EGCore/SwipePageViewController.h"
#import "TestReflection.h"
#import "EGCore/SwipeDataSource.h"
#import "TestShadingAnimationView.h"

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


-(void) testJson
{
    int sum = [[SwipeDataSource instance] getPageCount];
    NSLog(@"sum=%d", sum);
    
    NSDictionary *data = [[SwipeDataSource instance] getPage:@"page2_1"];
    NSLog(@"data=%@", data);
}



-(void) testcase
{
//  [self testJson];
//  rootViewController = [[SwipePageViewController alloc] init];
//  rootViewController = [[TestAnimationViewController alloc] init];
//  rootViewController = [[TestReflectionView alloc] init];
    rootViewController = [[TestShadingAnimationView alloc] init];
    
    
    self.window.rootViewController = rootViewController;
}


@end















