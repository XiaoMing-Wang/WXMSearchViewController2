//
//  WXMSearchBar.m
//  Multi-project-coordination
//
//  Created by wq on 2020/2/15.
//  Copyright © 2020 wxm. All rights reserved.
//
#define WXMCancelH 50
#define WXMDuration .265
#import "WXMSearchBar.h"
#import "UIView+WXMSearch.h"
#import "WXMSeaechConfiguration.h"

@interface WXMSearchBar ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIControl *searchBackground;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) UILabel *searchPlace;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) BOOL isAnimation;

@end

@implementation WXMSearchBar

+ (instancetype)searchBar {
    CGRect frame = CGRectMake(0, 0, kSearchWidth, WXMSeaechTextH + 2 * WXMTextMargin);
    WXMSearchBar *search = [[WXMSearchBar alloc] initWithFrame:frame];
    [search.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [search initializationInterface];
    return search;
}

- (void)initializationInterface {
    self.duration = WXMDuration;
    self.backgroundColor = [UIColor greenColor];
    UIControlEvents event = UIControlEventTouchUpInside;
    UIControlEvents allEvents = UIControlEventAllEvents;
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kSearchWidth, 20)];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.alpha = 0;
    
    CGFloat width = kSearchWidth - 2 * WXMSeaechMargin;
    self.searchBackground = [[UIControl alloc] init];
    self.searchBackground.frame = CGRectMake(WXMSeaechMargin, WXMTextMargin, width, WXMSeaechTextH);
    self.searchBackground.backgroundColor = [UIColor whiteColor];
    self.searchBackground.layer.cornerRadius = WXMSeaechCornerRadius;
    self.searchBackground.layer.masksToBounds = YES;
    [self.searchBackground addTarget:self action:@selector(editingEvents) forControlEvents:event];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0,0,width-15,WXMSeaechTextH)];
    self.textField.font = [UIFont systemFontOfSize:16];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.inputAccessoryView = [UIView new];
    self.textField.alpha = 0;
    self.textField.left = WXMSeaechIconText + WXMSeaechIconWH + 7.5;
    self.textField.centerY = self.searchBackground.height / 2.0;
    [self.textField addTarget:self action:@selector(eventAllEvents) forControlEvents:allEvents];
    
    self.cancelButton = [[UIButton alloc] init];
    self.cancelButton.frame = CGRectMake(kSearchWidth, 0, WXMCancelH, self.height);
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.5];
    [self.cancelButton setTitle:WXMSeaechCancel forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:WXMSeaechCancelColor forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelEvents) forControlEvents:event];
    
    self.searchIcon = [[UIImageView alloc] init];
    self.searchIcon.frame = CGRectMake(0, 0, WXMSeaechIconWH, WXMSeaechIconWH);
    self.searchIcon.image = [UIImage imageNamed:@"searchIcon"];
    
    self.searchPlace = [[UILabel alloc] init];
    self.searchPlace.font = [UIFont systemFontOfSize:16];
    self.searchPlace.text = WXMSeaechPlace;
    self.searchPlace.textColor = [UIColor grayColor];
    [self.searchPlace sizeToFit];
      
    [self.searchBackground addSubview:self.textField];
    [self.searchBackground addSubview:self.searchIcon];
    [self.searchBackground addSubview:self.searchPlace];
    [self addSubview:self.searchBackground];
    [self addSubview:self.cancelButton];
    [self addSubview:self.topView];
    [self setEdit:NO];
}

- (void)cancelEvents {
    [self setEditWithAnimation:NO];
}

- (void)editingEvents {
    if (!self.editing) [self setEditWithAnimation:YES];
}

/** 无动画 */
- (void)setEdit:(BOOL)editor {
    self.duration = 0.0;
    [self setEditWithAnimation:editor];
}

/** 有动画 */
- (void)setEditWithAnimation:(BOOL)editor {
    if (self.isAnimation) return;
    
    self.isAnimation = YES;
    self.editing = editor;
    self.textField.text = @"";
    
    editor ? [self.textField becomeFirstResponder] : [self.textField resignFirstResponder];
    editor ? [self.topView setAlpha:1] : nil;
        
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
           
        if (editor) {
                       
            self.cancelButton.right = kSearchWidth - 1.5;
            self.searchBackground.width = kSearchWidth - 2 * WXMSeaechMargin - WXMCancelH;
            
            self.searchIcon.left = 10.0;
            self.searchIcon.centerY = self.searchBackground.height / 2.0;
            
            self.searchPlace.left = self.searchIcon.right + WXMSeaechIconText;
            self.searchPlace.centerY = self.searchBackground.height / 2.0;
            
            self.textField.width = self.searchBackground.width - self.textField.left;
            
        } else {
                       
            self.cancelButton.left = kSearchWidth;
            self.searchBackground.width = kSearchWidth - 2 * WXMSeaechMargin;
            
            self.searchIcon.right = self.searchBackground.width / 2.0 - WXMSeaechIconText - 2.0;
            self.searchIcon.centerY = self.searchBackground.height / 2.0;
            
            self.searchPlace.left = self.searchIcon.right + WXMSeaechIconText;
            self.searchPlace.centerY = self.searchBackground.height / 2.0;
            
            self.textField.width = self.searchBackground.width - self.textField.left;
        }
        
        if ([self.delegate respondsToSelector:@selector(searchBarEditorSatatus:)]) {
            [self.delegate searchBarEditorSatatus:editor];
        }
        
    } completion:^(BOOL finished) {
        self.isAnimation = NO;
        self.duration = WXMDuration;
        self.textField.alpha = editor;
        !editor ? [self.topView setAlpha:0] : nil;
    }];
}

- (void)eventAllEvents {
    self.searchPlace.hidden = (self.textField.text.length > 0);
    if ([self.delegate respondsToSelector:@selector(searchBarTextFliedChane:)]) {
        [self.delegate searchBarTextFliedChane:self.textField.text];
    }
}

- (void)setSearchBackgroundColor:(UIColor *)searchBackgroundColor {
    _searchBackgroundColor = searchBackgroundColor;
    self.backgroundColor = searchBackgroundColor;
    self.topView.backgroundColor = searchBackgroundColor;
}

- (BOOL)isKindOfClass:(Class)aClass {
    if (aClass == [UISearchBar class]) return YES;
    return [super isKindOfClass:aClass];
}

@end
