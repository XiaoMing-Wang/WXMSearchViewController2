//
//  WXMSearchViewController.m
//  Multi-project-coordination
//
//  Created by wq on 2020/2/15.
//  Copyright © 2020 wxm. All rights reserved.
//
#import "UIView+WXMSearch.h"
#import "WXMSearchViewController.h"
#import "WXMSeaechConfiguration.h"
#import "WXMSearchResultsViewController.h"

@implementation WXMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSettingsInterface];
    [self initializationInterface];
}

- (Class)cellClass {
    return [UITableViewCell class];
}

- (UIColor *)navigationbarColor {
    return UIColor.whiteColor;
}

- (void)customSettingsInterface {
    self.navigationItem.title = @"搜索";
    [self.tableView registerClass:self.cellClass forCellReuseIdentifier:@"cell"];
}

- (void)initializationInterface {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.searchBar;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) self.automaticallyAdjustsScrollViewInsets = NO;
        
    UIImage *images = [self colorToImage:UIColor.whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:images forBarMetrics:0];
    [self.navigationController.navigationBar setShadowImage:images];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.resultsViewController.view];
    [self addChildViewController:self.resultsViewController];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tab cellForRowAtIndexPath:(NSIndexPath *)index {
    UITableViewCell *cell = [tab dequeueReusableCellWithIdentifier:@"cell" forIndexPath:index];
    [self loadCell:cell dataSource:self.dataSource index:index];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)loadCell:(UITableViewCell *)cell dataSource:(NSArray *)data index:(NSIndexPath *)index {
    cell.textLabel.text = @(index.row).stringValue;
}

/** 设置搜索数据 */
- (void)setResultDataSources:(__kindof NSArray *)arrays {
    self.resultsViewController.dataSource = arrays;
    [self.resultsViewController.tableView reloadData];
}

#pragma mark delegate
- (void)searchBarEditorSatatus:(BOOL)editor {
    [self.navigationController setNavigationBarHidden:editor animated:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = !editor;
    
    if (editor) {
        
        self.tableView.top = kStatusHeight;
        self.tableView.scrollEnabled = NO;
        self.tableView.clipsToBounds = NO;
        self.resultsViewController.view.alpha = 1;
        self.resultsViewController.view.top = WXMSearchHeight + kStatusHeight;
        
    } else {
        
        [self setResultDataSources:@[]];
        self.tableView.top = 0;
        self.tableView.scrollEnabled = YES;
        self.resultsViewController.view.alpha = 0;
        self.resultsViewController.view.top = WXMSearchHeight;
    }
}

- (void)searchBarEditorEnd:(BOOL)editor {
    self.tableView.clipsToBounds = !editor;
    if (!editor) [self.resultsViewController.tableView setContentOffset:CGPointZero];
}

- (void)searchBarTextFliedChane:(NSString *)aString {
      
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, kSearchWidth, kSearchHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame];
        _tableView.rowHeight = 49;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (WXMSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [WXMSearchBar searchBar];
        
        _searchBar.searchBackgroundColor = [UIColor colorWithRed:(237) / 255.0f
                                                           green:(237) / 255.0f
                                                            blue:(237) / 255.0f alpha:1];
        
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (WXMSearchResultsViewController *)resultsViewController {
    if (!_resultsViewController) {
        __weak typeof(self) weakSelf = self;
        _resultsViewController = [[WXMSearchResultsViewController alloc] init];
        _resultsViewController.cellClass = self.cellClass;
        _resultsViewController.view.top =  WXMSearchHeight;
        _resultsViewController.view.height = kSearchHeight - WXMSearchHeight - kStatusHeight;
        _resultsViewController.tableView.height = _resultsViewController.view.height;
        _resultsViewController.view.alpha = 0;
        _resultsViewController.view.backgroundColor = self.searchBar.searchBackgroundColor;
        _resultsViewController.view.backgroundColor = [UIColor yellowColor];
        _resultsViewController.loadCellData = ^(UITableViewCell *cell, NSArray *data,NSIndexPath *ip) {
            [weakSelf loadCell:cell dataSource:data index:ip];
        };
        
        _resultsViewController.callbackResult = ^(id result) {
            NSInteger row = [weakSelf.dataSource indexOfObject:result];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:indexPath];
        };
    }
    return _resultsViewController;
}

- (UIImage *)colorToImage:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
