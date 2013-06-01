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
#import "AppDataSource.h"


@implementation SwipePageViewController
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
//    int catagory = [[AppDataSource instance] currentCatagory];
//    NSString *catagoryName = [NSString stringWithFormat:@"catagory%d", catagory];
    return [[AppDataSource instance] getWidgetCountInJson:@"catagory1"];
}


- (UIView *)swipeView:(SwipeView *)_swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        view = [datasource objectForKey:[NSNumber numberWithInteger:index]];
        if( !view ){
            view =[[SwipePageView alloc] init];
            [datasource setObject:view forKey:[NSNumber numberWithInteger:index]];
            [(SwipePageView*)view resetContentWithIndex:index+1 ];
        }
    } else {
        [(SwipePageView*)view resetContentWithIndex:index+1 ];        
    }    
//    NSLog(@"index=%d, view=%@", index, view);
    return view;
}


- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    SwipePageView *cell = (SwipePageView *)[swipeView currentItemView];
    [cell swipeViewDidScroll:swipeView];
}




@end
