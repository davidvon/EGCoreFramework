//
//  SwipeWebViewController.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-27.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import "SwipeWebViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SwipeWebView.h"
#import "EGCore/PathFile.h"
#import "EGCore/ZipArchive.h"

@implementation SwipeWebViewController
@synthesize swipe, datasource, currentModule;

- (id)initWithModule:(NSString*)module
{
    self = [super init];
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
        datasource = [[NSMutableDictionary alloc] init];
        currentModule = module;
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        [self loadSwipeView];
        [self initStaticWebPages];
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


-(void) copyWebFiles:(NSString*)path
{
    NSString *defaultZipFile  = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"static/modules/default.zip"];
    ZipArchive *za = [[ZipArchive alloc] init];
    if ([za UnzipOpenFile:defaultZipFile]) {
        [za UnzipFileTo:path overWrite: YES];
        [za UnzipCloseFile];
    }    
}

-(void) initStaticWebPages
{
    NSString *destDir = [[PathFile documentPath] stringByAppendingPathComponent:@"modules"];
    bool isExist = [[NSFileManager defaultManager] fileExistsAtPath:destDir];
	if ( !isExist ) {
        [[NSFileManager defaultManager] createDirectoryAtPath:destDir withIntermediateDirectories:true attributes:nil error:nil];
        [self copyWebFiles:destDir];
        return;
    }
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:destDir error:nil];
    if( array.count == 0 ){
        [self copyWebFiles:destDir];
    }
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
    NSString *destDir = [[[PathFile documentPath] stringByAppendingPathComponent:@"modules"] stringByAppendingPathComponent:currentModule];
    NSArray *array =[PathFile fileListInFolder:destDir filterBySuffix:@"html"];
    return [array count];
}


- (UIView *)swipeView:(SwipeView *)_swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        view = [datasource objectForKey:[NSNumber numberWithInteger:index]];
        if( !view ){
            view =[[SwipeWebView alloc] initWithModule:currentModule];
            [datasource setObject:view forKey:[NSNumber numberWithInteger:index]];
            [(SwipeWebView*)view resetContentWithIndex:index];
            ((SwipeWebView*)view).webVcDelegate = self;
        }
    } else {
        [(SwipeWebView*)view resetContentWithIndex:index];
        ((SwipeWebView*)view).webVcDelegate = self;
    }

    return view;
}


- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    SwipeWebView *cell = (SwipeWebView *)[swipeView currentItemView];
    [cell swipeViewDidScroll:swipeView];
}


-(void) gotoPage:(int)index
{
    [self.swipe scrollToPage:index duration:0.4];
}
    
@end
