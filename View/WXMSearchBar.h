//
//  WXMSearchBar.h
//  Multi-project-coordination
//
//  Created by wq on 2020/2/15.
//  Copyright © 2020 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMSearchTextField.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WXMSearchBarDelegate <NSObject>
- (void)searchBarTextFliedChane:(NSString *)aString;
- (void)searchBarEditorSatatus:(BOOL)editor;
@end

@interface WXMSearchBar : UIView

/** 代理 */
@property (nonatomic, assign) id <WXMSearchBarDelegate>delegate;

/** 搜索框 */
@property (nonatomic, strong) WXMSearchTextField *searchTextField;

/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancelButton;

/** 颜色 */
@property (nonatomic, strong) UIColor *searchBackgroundColor;

/** 编辑中 */
@property (nonatomic, assign) BOOL editing;

/** 创建searchBar */
+ (instancetype)searchBar;

/** 无动画 */
- (void)setEdit:(BOOL)editor;

/** 有动画 */
- (void)setEditWithAnimation:(BOOL)editor;

@end

NS_ASSUME_NONNULL_END
