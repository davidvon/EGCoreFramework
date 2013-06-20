//
//  SwipeWebViewController.m
//  EGCoreFrameworkDemo
//
//  Created by feng guanhua on 13-5-27.
//  Copyright (c) 2013年 feng guanhua. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SwipeWebViewController.h"
#import "UpdateViewController.h"
#import "SwipeWebView.h"
#import "EGCore/PathFile.h"
#import "EGCore/ZipArchive.h"
#import "EGCore/JSONKit.h"
#import "EGCore/Constant.h"
#import "EGCore/EGViewCoreAnimate.h"


@implementation SwipeWebViewController
@synthesize swipe, datasource, currentModule;
@synthesize modulePath, pageList, updateDate, updatePopVc;

- (id)initWithModule:(NSString*)module
{
    self = [super init];
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
        datasource = [[NSMutableDictionary alloc] init];
        currentModule = module;
        modulePath = [[[PathFile documentPath] stringByAppendingPathComponent:@"modules/default"]
                      stringByAppendingPathComponent:currentModule];
        self.view.frame = CGRectMake(0, 0, 1024, 768);
        [self loadSwipeView];
        [self checkPackageStatus];
        UIButton *down =[Constant addButton:CGRectMake(680, 50, 68, 68) withImage:@"download_normal.png" inView:self.view];
        [down addTarget:self action:@selector(download) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void) download
{
    if(!updatePopVc){
        UpdateViewController *updateVC = [[UpdateViewController alloc] init];
        UINavigationController *updateNavVC = [[UINavigationController alloc] initWithRootViewController:updateVC];
        updateNavVC.view.frame = CGRectMake(262,100, 500,500);
        updateVC.view.frame = updateNavVC.view.bounds;
        updateVC.swipeWebVc = self;
        updatePopVc = [[UIPopoverController alloc] initWithContentViewController:updateNavVC];
        updatePopVc.popoverContentSize = CGSizeMake(500, 500);
    }
    [updatePopVc presentPopoverFromRect:CGRectMake(262, 100, 500, 500) inView:self.view permittedArrowDirections:0 animated:YES];
}


-(void) popDownloadView
{
    [updatePopVc dismissPopoverAnimated:true];
}


-(void) checkPackageStatus
{
    [self initStaticWebPages];
    _isIndexJsonFileExist = [PathFile isFileExistsAtPath:modulePath fileName:kAppJsonFile];
    if( !_isIndexJsonFileExist ) return;
    
    NSString *filePath = [modulePath stringByAppendingPathComponent:kAppJsonFile];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dict = [content objectFromJSONString];
    updateDate = [dict objectForKey:@"date"];
    pageList = [dict objectForKey:@"pages"];
}


-(void) initStaticWebPages
{
    NSString *destDir = [[PathFile documentPath] stringByAppendingPathComponent:@"modules"];
    bool isExist = [[NSFileManager defaultManager] fileExistsAtPath:destDir];
	if ( isExist ){
        NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:destDir error:nil];
        if( array.count > 0 ) return;
    } else {
        [[NSFileManager defaultManager] createDirectoryAtPath:destDir withIntermediateDirectories:true attributes:nil error:nil];
    }
    NSString *file = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"static/modules/default.zip"];
    [SwipeWebViewController unzipFiles:file toDest:destDir];
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

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = true;
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
    NSString *destDir = [[[PathFile documentPath] stringByAppendingPathComponent:@"modules/default/"] stringByAppendingPathComponent:currentModule];
    NSArray *array =[PathFile fileListInFolder:destDir filterBySuffix:@"html"];
    return [array count];
}


- (UIView *)swipeView:(SwipeView *)_swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
        view = [datasource objectForKey:[NSNumber numberWithInteger:index]];
        if( !view ){
            view =[[SwipeWebView alloc] initWithModule:currentModule delegate:self];
            [datasource setObject:view forKey:[NSNumber numberWithInteger:index]];
            [(SwipeWebView*)view resetContentWithIndex:index];
        }
    } else {
        [(SwipeWebView*)view resetContentWithIndex:index];
    }

    return view;
}


- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    SwipeWebView *cell = (SwipeWebView *)[swipeView currentItemView];
    [cell swipeViewDidScroll:swipeView];
}


#pragma mark --- Swipe WebView Delegate ---
-(void) gotoPage:(NSString*)pageName
{
    int index = 0;
    if(pageList){
        index = [pageList indexOfObject:pageName];
    } else if( pageName ) {
        NSRange range = [pageName rangeOfString:@".html"];
        NSString *name = [pageName substringToIndex:range.location];
        index = [name integerValue];
    }
    [self.swipe scrollToPage:index duration:0.4];
}


-(NSString*) pageNameByIndex:(NSInteger)index
{
    NSString *page = [pageList objectAtIndex:index];
    return page;
}




#pragma mark --- zip file check ---
-(bool) updateVerifyZipFile:(NSString*)zipFile
{
    bool res = [SwipeWebViewController isZipFileValid:zipFile];
    if( !res ) return FALSE;
    
    NSString *path = [[PathFile documentPath] stringByAppendingPathComponent:@"modules/update"];
    [PathFile filesDelete:path];
    [SwipeWebViewController unzipFiles:zipFile toDest:path];
    return TRUE;
}



+(void) unzipFiles:(NSString*)zipFile toDest:(NSString*)dest
{
    ZipArchive *za = [[ZipArchive alloc] init];
    if ([za UnzipOpenFile:zipFile]) {
        [za UnzipFileTo:dest overWrite: YES];
        [za UnzipCloseFile];
    }
}


+(bool) isZipFileValid:(NSString*)file
{
    NSString *tempPath = NSTemporaryDirectory();
    [SwipeWebViewController unzipFiles:file toDest:tempPath];
    
//    NSArray *array = [PathFile allFilesInPathAndItsSubpaths:tempPath filterBySuffix:@"html"];
    NSString *dir = [tempPath stringByAppendingPathComponent:@"yzlg"];
    NSArray *array =[PathFile fileListInFolder:dir filterBySuffix:@"html"];
    if( [array count] == 0 ) return FALSE;
    return TRUE;
}



@end
