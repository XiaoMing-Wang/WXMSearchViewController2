//
//  WXMSearchViewController.h
//  Multi-project-coordination
//
//  Created by wq on 2020/2/15.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMSearchBar.h"
#import "WXMSeaechConfiguration.h"
#import "WXMSearchResultsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXMSearchViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, WXMSearchBarDelegate>

/** 搜索框 */
@property (nonatomic, strong) WXMSearchBar *searchBar;

/** 结果界面 */
@property (nonatomic, strong) WXMSearchResultsViewController *resultsViewController;

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;

/** 数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/** 初始化 */
- (void)initializationInterface;

/** 设置搜索数据 */
- (void)setResultDataSources:(__kindof NSArray *)arrays;
    
    /// 子类重写加载
/// @param cell cell
/// @param dataSource 数组
/// @param index 下标
- (void)loadCell:(UITableViewCell *)cell dataSource:(NSArray *)dataSource index:(NSIndexPath *)index;

@end

NS_ASSUME_NONNULL_END
