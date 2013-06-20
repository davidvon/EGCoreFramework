//
//  UpdateViewController.h
//  downloadManager
//
//

#import <UIKit/UIKit.h>
#import "progressCell.h"


#define website @"http://d.pcs.baidu.com/file/f2ac2a13919c3a72eb7d9e01f0ad4dfd?fid=1477463264-250528-474030780&time=1371742968&sign=FDTAR-DCb740ccc5511e5e8fedcff06b081203-0fhOIaDogfhsBWW8VcEl6w2BlwI%3D&rt=sh&expires=8h&r=389841589&sh=1&response-cache-control=private"

//http://gdown.baidu.com/data/wisegame/b9529ea2381cbac0/ZAKER_70.apk


@class SwipeWebViewController;
@class DetailViewController;

@interface UpdateViewController : UITableViewController <progressCellDelegate>
@property (nonatomic, weak) SwipeWebViewController *swipeWebVc;
@end

