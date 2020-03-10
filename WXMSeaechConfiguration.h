//
//  WXMSeaechConfiguration.h
//  Multi-project-coordination
//
//  Created by wq on 2020/2/15.
//  Copyright © 2020 wxm. All rights reserved.
//

#ifndef WXMSeaechConfiguration_h
#define WXMSeaechConfiguration_h

/** TextField 高度 */
#define WXMSeaechTextH 36.0

/** TextField 上下边距 */
#define WXMTextMargin 8.0

/** 总高度 */
#define WXMSearchHeight (WXMSeaechTextH + WXMTextMargin * 2)

/** searchbar 左右边距 */
#define WXMSeaechMargin 10.0

/** 搜索图标大小 */
#define WXMSeaechIconWH 20.0

/** searchbar 圆角 */
#define WXMSeaechCornerRadius 6.0

/** icon和字间隔 */
#define WXMSeaechIconText 6.0

/** 搜索按钮 */
#define WXMSeaechPlace @"搜索"

/** 取消按钮 */
#define WXMSeaechCancel @"取消"

/** 取消颜色 */
#define WXMSeaechCancelColor [UIColor colorWithRed:(98) / 255.0f green:(106) / 255.0f blue:(134) / 255.0f alpha:1]

#define kSearchWindow [[[UIApplication sharedApplication] delegate] window]
#define kSearchWidth [UIScreen mainScreen].bounds.size.width
#define kSearchHeight [UIScreen mainScreen].bounds.size.height
#define kTableHeight kSearchHeight - kSearchBHeight

#define kSearchBHeight ((kSearchIPhoneX) ? 88.0f : 64.0f)
#define kSearchSafeHeight ((kSearchIPhoneX) ? 25.0f : 0.0f)

#define kSearchIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);\
})

#endif /* WXMSeaechConfiguration_h */
