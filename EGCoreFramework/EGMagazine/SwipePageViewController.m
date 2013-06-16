//
//  SwipePageViewController.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-27.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipePageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SwipePageView.h"
#import "SwipePageDataSource.h"
#import "EGReflection.h"

@implementation SwipePageViewController
@synthesize swipe,datasource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
        datasource = [[NSMutableDictionary alloc] init];
        [self loadSwipeView];
    }
    return self;
}


-(void)loadSwipeView
{
    self.swipe = [[SwipeView alloc] init];
    self.swipe.delegate = self;
    self.swipe.dataSource = self;
    self.swipe.alignment = SwipeViewAlignmentCenter;
    self.swipe.pagingEnabled = YES;
    self.swipe.wrapEnabled = NO;
    self.swipe.itemsPerPage = 1;
    self.swipe.truncateFinalPage = FALSE;
    self.swipe.frame = CGRectMake(0, 0, 1024, 768);
    self.swipe.backgroundColor = [UIColor brownColor];
    [self.view addSubview:self.swipe];
    [self addFetureViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) dealloc
{
    [datasource removeAllObjects];
}


-(void)reloadData
{
    [swipe reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    int count = [[SwipePageDataSource instance] getPageCount];
    return count;
}


- (UIView *)swipeView:(SwipeView *)_swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        view = [datasource objectForKey:[NSNumber numberWithInteger:index]];
        if( !view ){
            view =[[SwipePageView alloc] init];
            [datasource setObject:view forKey:[NSNumber numberWithInteger:index]];
            [(SwipePageView*)view resetContentWithIndex:index ];
        }
    } else {
        [(SwipePageView*)view resetContentWithIndex:index ];        
    }    
    return view;
}


- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    SwipePageView *cell = (SwipePageView *)[swipeView currentItemView];
    [cell swipeViewDidScroll:swipeView];
}


-(void) addFetureViews
{
    NSArray *views = [[SwipePageDataSource instance] getAppViews];
    for( int i=0; i<views.count; i++ ){
        NSDictionary *dic = [views objectAtIndex:i];
        NSString *className = [dic objectForKey:@"class"];
        NSDictionary *pos = [dic objectForKey:@"position"];
        NSArray *framearray = [pos objectForKey:@"from"];
        int x = [[framearray objectAtIndex:0] integerValue];
        int y = [[framearray objectAtIndex:1]integerValue];
        int w = [[framearray objectAtIndex:2]integerValue];
        int h = [[framearray objectAtIndex:3]integerValue];
        CGRect rect = CGRectMake(x,y,w,h);
        Class classType = NSClassFromString(className);
        UIView *instance = [[classType alloc] initWithFrame:rect];
        [self.view addSubview:instance];
    }
}



@end
