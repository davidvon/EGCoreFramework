//
//  UpdateViewController.m
//  downloadManager
//

#import "UpdateViewController.h"
#import "progressCell.h"
#import "EGCore/Constant.h"
#import "EGCore/EGViewCoreAnimate.h"
#import "EGCore/PathFile.h"
#import "SwipeWebViewController.h"

#define DELETE_DONE 0

@implementation UpdateViewController
@synthesize swipeWebVc;

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.view.backgroundColor = CLEAR_COLOR;
        
        UILabel *bg = [[UILabel alloc] initWithFrame:self.view.bounds];
        NSString* path = [[NSBundle mainBundle] pathForResource:@"bg_main" ofType:@"png"];
        bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:path]];
        [self.tableView setBackgroundView:bg];
        self.title = @"更新";
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self action:@selector(saveAndReturn)];
        [self.navigationItem setRightBarButtonItem: saveButton];
        
    }
    return self;
}

-(void) viewDidLoad
{
    self.navigationController.toolbarHidden = NO;
    self.navigationController.hidesBottomBarWhenPushed = TRUE;
}



#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 2 ) return 200;
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 0 ) return [self updateTipInfoTableViewCell:tableView];
    if( indexPath.row == 1 ) return [self progressTableViewCell:tableView];
    if( indexPath.row == 2 ) return [self webAddressTableViewCell:tableView];
    return nil;
}


-(UITableViewCell*) updateTipInfoTableViewCell:(UITableView*)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCell"];
        cell.textLabel.text = @"上次更新时间";
        
        NSString *date = [[NSUserDefaults standardUserDefaults] objectForKey:kUpdateDate];
        cell.detailTextLabel.text = date? date:@"2013-3-4";
        cell.tag = 1001;
        return cell;
    }
    return cell;    
}

-(progressCell*) progressTableViewCell:(UITableView*)tableView
{
    progressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressCell"];
    if (cell == nil) {
        progressCell *cell = [[progressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProgressCell" downloadURL:[NSURL URLWithString:website]];
        cell.textLabel.text = @"更新";
        cell.delegate = self;
        return cell;        
    }
    return cell;
}


-(UITableViewCell*) webAddressTableViewCell:(UITableView*)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCell"];
        cell.textLabel.text = @"远程路径";
        cell.detailTextLabel.text = website;
        cell.detailTextLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        cell.detailTextLabel.numberOfLines = 0;        
        return cell;
    }
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - progressCell
-(void)progressCellDownloadProgress:(float)progress Percentage:(NSInteger)percentage ProgressCell:(progressCell *)cell
{
    cell.textLabel.text = [NSString stringWithFormat:@"下载：%d %%",percentage];
}


-(void)progressCellDownloadFinished:(NSData*)fileData ProgressCell:(progressCell *)cell{
    NSString *tempPath = NSTemporaryDirectory();
    [PathFile filesDelete:tempPath];

    NSString *file = [tempPath stringByAppendingPathComponent:@"book.zip"];
    [fileData writeToFile:file atomically:true];
    bool res = [swipeWebVc updateVerifyZipFile:file];
    cell.textLabel.text = res ? @"更新成功":@"更新失败";
    cell.textLabel.textColor = res ? [UIColor blueColor]:[UIColor redColor];
    if( res ) [self updateDateLabel];
}


-(void)progressCellDownloadFail:(NSError*)error ProgressCell:(progressCell *)cell{
    cell.textLabel.text = @"更新失败";
}


-(void) saveAndReturn
{
    [swipeWebVc performSelector:@selector(popDownloadView) withObject:nil];
}


-(void) updateDateLabel
{
    UITableViewCell *dateView = (UITableViewCell *)[self.tableView viewWithTag:1001];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate date];
    NSString *dateStr = [dateformatter stringFromDate:date];
    NSLog(@"date:%@",dateStr);
    dateView.detailTextLabel.text = dateStr;
    [[NSUserDefaults standardUserDefaults] setObject:dateStr forKey:kUpdateDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end


