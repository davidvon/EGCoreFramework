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
#import "AppDataSource.h"

@implementation AppDelegate
@synthesize rootViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

//    [self testJson];
  [self testcase];
    
    return YES;
}


-(void) testJson
{
    int sum = [[AppDataSource instance] getWidgetCountInJson:@"catagory2"];
    NSLog(@"sum=%d", sum);
    
    NSDictionary *data = [[AppDataSource instance] getPageInJson:@"page2_1"];
    NSLog(@"data=%@", data);
}

-(void) testcase
{
    rootViewController = [[TestSwipeViewController alloc] init];
//  rootViewController = [[TestAnimationViewController alloc] init];
//  rootViewController = [[TestReflectionView alloc] init];
    self.window.rootViewController = rootViewController;
}


@end
