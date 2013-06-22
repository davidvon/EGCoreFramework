//
//  UpdateViewController.m
//  downloadManager
//

#import "UpdateViewController.h"
#import "ProgressCell.h"
#import "EGCore/Constant.h"
#import "EGCore/EGViewCoreAnimate.h"
#import "EGCore/PathFile.h"
#import "SwipeWebViewController.h"

#define DELETE_DONE 0

@implementation UpdateViewController
@synthesize swipeWebVc, textview, webUrl, saveButton, cancelButton;

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
        NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:kWebUrl];
        webUrl = url ? url:kWebsite;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1) return 1;
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1) return 30;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1 && indexPath.row == 0) return 120;
    return 45;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if( indexPath.row == 0 ) return [self updateTipInfoTableViewCell:tableView];
        if( indexPath.row == 1 ) return [self progressTableViewCell:tableView];
    }else{
        if( indexPath.row == 0 ) return [self webAddressTableViewCell:tableView];
    }
    return nil;
}


-(UITableViewCell*) updateTipInfoTableViewCell:(UITableView*)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCell"];
        cell.textLabel.text = @"上次更新时间";
        cell.textLabel.textColor = GRAY_COLOR;
        NSString *date = [[NSUserDefaults standardUserDefaults] objectForKey:kUpdateDate];
        cell.detailTextLabel.text = date? date:@"2013-5-1";
        cell.tag = 1001;
        return cell;
    }
    return cell;
}

-(ProgressCell*) progressTableViewCell:(UITableView*)tableView
{
    ProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressCell"];
    if (cell == nil) {
        
        ProgressCell *cell = [[ProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProgressCell" downloadURL:[NSURL URLWithString:webUrl]];
        cell.textLabel.text = @"更新";
        cell.textLabel.textColor = GRAY_COLOR;
        cell.delegate = self;
        cell.tag = 1002;
        return cell;        
    }
    return cell;
}


-(UITableViewCell*) webAddressTableViewCell:(UITableView*)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TableViewCell"];
        if(!textview){
            CGRect rect = CGRectMake(35, 5, 400, 110);
            textview = [[UITextView alloc] initWithFrame: rect];
            textview.backgroundColor = CLEAR_COLOR;
            textview.font = [UIFont systemFontOfSize:13];
            textview.textColor = [UIColor grayColor];
            [textview setDelegate: self];
            textview.returnKeyType = UIReturnKeyDone;
            textview.text = webUrl;
            [cell addSubview:textview];
            
            saveButton = [Constant addButton:CGRectMake(433,30,26,26) withImage:@"checked" inView:cell];
            cancelButton = [Constant addButton:CGRectMake(430,60,32,32) withImage:@"deleted" inView:cell];
            [saveButton addTarget:self action:@selector(saveWebAddress:) forControlEvents:UIControlEventTouchUpInside];
            [cancelButton addTarget:self action:@selector(cancelWebAddress:) forControlEvents:UIControlEventTouchUpInside];
            saveButton.hidden = true;
            cancelButton.hidden = true;
        }
        return cell;
    }
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if( section == 1){
        NSString *HeaderString = [NSString stringWithFormat:@"远程路径"];
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        UILabel *HeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, 40)];
        HeaderLabel.backgroundColor = [UIColor clearColor];
        HeaderLabel.font = [UIFont boldSystemFontOfSize:16];
        HeaderLabel.textColor = [UIColor lightGrayColor];
        HeaderLabel.text = HeaderString;
        [header addSubview:HeaderLabel];
        return header;
    }
    return nil;
}


#pragma mark -- textview edit delegate --
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}


-(void) saveWebAddress:(id)sender
{
    ProgressCell *progresscell = (ProgressCell *)[self.tableView viewWithTag:1002];
    webUrl = textview.text;
    [progresscell setURL:webUrl];
    
    [[NSUserDefaults standardUserDefaults] setObject:webUrl forKey:kWebUrl];
    [[NSUserDefaults standardUserDefaults] synchronize];    
    [textview resignFirstResponder];
    saveButton.hidden = true;
    cancelButton.hidden = true;
}

-(void) cancelWebAddress:(id)sender
{
    [textview resignFirstResponder];
    saveButton.hidden = true;
    cancelButton.hidden = true;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    saveButton.hidden = false;
    cancelButton.hidden = false;
}


-(void)textViewDidEndEditing:(UITextView *)textView {
    [textView resignFirstResponder];  
}


#pragma mark - progressCell
-(void)progressCellDownloadProgress:(float)progress Percentage:(NSInteger)percentage ProgressCell:(ProgressCell *)cell
{
    cell.textLabel.text = [NSString stringWithFormat:@"下载：%d %%",percentage];
}


-(void)progressCellDownloadFinished:(NSData*)fileData ProgressCell:(ProgressCell *)cell{
    NSString *tempPath = NSTemporaryDirectory();
    [PathFile filesDelete:tempPath];

    NSString *file = [tempPath stringByAppendingPathComponent:@"book.zip"];
    [fileData writeToFile:file atomically:true];
    bool res = [swipeWebVc updateVerifyZipFile:file];
    cell.textLabel.text = res ? @"更新成功":@"更新失败";
    cell.textLabel.textColor = res ? [UIColor blueColor]:[UIColor redColor];
    if( res ){
        [self updateDateLabel];
        NSNotification *notification = [NSNotification notificationWithName:kUpdateNotifyKey object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}


-(void)progressCellDownloadFail:(NSError*)error ProgressCell:(ProgressCell *)cell{
    cell.textLabel.text = @"下载失败";
}


-(void) updateDateLabel
{
    UITableViewCell *dateView = (UITableViewCell *)[self.tableView viewWithTag:1001];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSString *dateStr = [dateformatter stringFromDate:date];
    NSLog(@"date:%@",dateStr);
    dateView.detailTextLabel.text = dateStr;
    [[NSUserDefaults standardUserDefaults] setObject:dateStr forKey:kUpdateDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end


