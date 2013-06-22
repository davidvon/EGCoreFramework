//
//  UpdateViewController.h
//  downloadManager
//
//

#import <UIKit/UIKit.h>
#import "ProgressCell.h"


@class SwipeWebViewController;
@class DetailViewController;

@interface UpdateViewController : UITableViewController <progressCellDelegate,UITextViewDelegate>
@property (nonatomic, weak) SwipeWebViewController *swipeWebVc;
@property (nonatomic, strong) UITextView *textview;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *cancelButton;
@end

