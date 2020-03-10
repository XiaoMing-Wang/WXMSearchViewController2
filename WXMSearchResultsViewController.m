//
//  WXMSearchResultsViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2020/2/15.
//  Copyright © 2020 wxm. All rights reserved.
//
#import "UIView+WXMSearch.h"
#import "WXMSeaechConfiguration.h"
#import "WXMSearchResultsViewController.h"

@implementation WXMSearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    if (!self.cellClass) self.cellClass = [UITableViewCell class];
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tab cellForRowAtIndexPath:(NSIndexPath *)index {
    UITableViewCell *cell = [tab dequeueReusableCellWithIdentifier:@"cell" forIndexPath:index];
    if (self.loadCellData) self.loadCellData(cell, self.dataSource, index);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [kSearchWindow endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.callbackResult) self.callbackResult(self.dataSource[indexPath.row]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [kSearchWindow endEditing:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.height = kSearchHeight - kSearchBHeight - WXMTextMargin;
        _tableView.rowHeight = 49;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorColor = [UIColor lightGrayColor];
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

@end
