//
//  progressCell.m
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import "progressCell.h"

@interface progressCell()
@property (nonatomic, strong) SGdownloader* download;
@property (nonatomic, strong) UIProgressView* progressV;
@property (nonatomic, strong) UIButton* updateButton;
@end
@implementation progressCell
@synthesize downloadedData = _downloadedData;
@synthesize download = _download;
@synthesize progressV = _progressV;
@synthesize delegate = _delegate;
@synthesize downloadURL = _downloadURL;
@synthesize updateButton = _updateButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier downloadURL:(NSURL*)url {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _progressV = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        
        _updateButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,27,27)];
        [_updateButton setBackgroundImage: [UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
        [_updateButton addTarget:self action:@selector(updateFile) forControlEvents:UIControlEventTouchUpInside];
        
        //default
        self.accessoryView = _updateButton;
        
        self.textLabel.text = @"0%";
        _downloadedData = nil;
        _downloadURL = url;        
    }
    return self;
}


-(void)updateFile
{
    _progressV.progress = 0;
    self.accessoryView = _progressV;
    _download = [[SGdownloader alloc] initWithURL:_downloadURL timeout:60];    
    [_download startWithDelegate:self];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - DownloadProcess
-(void)SGDownloadProgress:(float)progress Percentage:(NSInteger)percentage {
    
    _progressV.progress = progress;
    
    if([_delegate respondsToSelector:@selector(progressCellDownloadProgress:Percentage:ProgressCell:)]) {
        [_delegate progressCellDownloadProgress:progress Percentage:percentage ProgressCell:self];
    }
    
}
-(void)SGDownloadFinished:(NSData*)fileData {

    _downloadedData = fileData;
    
    if([_delegate respondsToSelector:@selector(progressCellDownloadFinished:ProgressCell:)])
    {
        [_delegate progressCellDownloadFinished:fileData ProgressCell:self];
    }
    self.accessoryView = _updateButton;
    _download = nil;
}

-(void)SGDownloadFail:(NSError*)error {

    if([_delegate respondsToSelector:@selector(progressCellDownloadFail:ProgressCell:)])
    {
        [_delegate progressCellDownloadFail:error ProgressCell:self];
    }
    self.accessoryView = _updateButton;
    _download = nil;    
}
@end
