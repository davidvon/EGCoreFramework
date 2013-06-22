//
//  progressCell.h
//  downloadManager
//
//  Created by Htain Lin Shwe on 11/7/12.
//  Copyright (c) 2012 Edenpod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGdownloader.h"

@class ProgressCell;
@protocol progressCellDelegate<NSObject>
@required
-(void)progressCellDownloadProgress:(float)progress Percentage:(NSInteger)percentage ProgressCell:(ProgressCell*)cell;
-(void)progressCellDownloadFinished:(NSData*)fileData ProgressCell:(ProgressCell*)cell;
-(void)progressCellDownloadFail:(NSError*)error ProgressCell:(ProgressCell*)cell; 
@end



@interface ProgressCell : UITableViewCell <SGdownloaderDelegate>
@property (nonatomic,readonly) NSData *downloadedData;
@property (nonatomic,strong)  NSURL *downloadURL;
@property (nonatomic,strong) id<progressCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier downloadURL:(NSURL*)url;
-(void)setURL:(NSString*)_url;

@end
