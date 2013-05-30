//
//  TestSwipeViewController.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-27.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "TestSwipeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SwipePageView.h"

@implementation TestSwipeViewController
@synthesize swipe,datasource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.view.backgroundColor = [UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:1];
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) dealloc
{
    [datasource removeAllObjects];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 4;
}


- (UIView *)swipeView:(SwipeView *)_swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        view = [datasource objectForKey:[NSNumber numberWithInteger:index]];
        if( !view ){
            view =[[SwipePageView alloc] init];
            [datasource setObject:view forKey:[NSNumber numberWithInteger:index]];
        }
    }
    [(SwipePageView*)view resetContentWithIndex:index+1 ];
    
    NSLog(@"view=%@",view);
    return view;
}


- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    SwipePageView *cell = (SwipePageView *)[swipeView currentItemView];
    [cell swipeViewDidScroll:swipeView];
}


- (void)swipeViewDidEndDragging:(SwipeView *)swipeView willDecelerate:(BOOL)decelerate
{
//    SwipePageView *cell = (SwipePageView *)[swipeView currentItemView];
//    [cell swipeViewDidEndDragging:swipeView];
}


@end
