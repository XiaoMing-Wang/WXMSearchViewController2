//
//  WXMSearchResultsViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2020/2/15.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXMSearchResultsViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>

/** 回调 */
@property (nonatomic, strong) void (^loadCellData) (UITableViewCell *, NSArray *, NSIndexPath *);

/** 回调 */
@property (nonatomic, strong) void (^callbackResult)(id result);

/** cellClass */
@property (nonatomic, strong) Class cellClass;

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;

/** 数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

NS_ASSUME_NONNULL_END
