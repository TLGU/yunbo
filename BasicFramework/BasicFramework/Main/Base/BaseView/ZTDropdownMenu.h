//
//  ZTDropdownMenu.h
//  SinaWeibo
//
//  Created by user on 15/10/16.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTDropdownMenu;

@protocol ZTDropdownMenuDelegate <NSObject>

@optional

- (void)dropdownMenuDidShow:(ZTDropdownMenu *)menu;
- (void)dropdownMenuDidDismiss:(ZTDropdownMenu *)menu;

@end

@interface ZTDropdownMenu : UIView

@property (nonatomic, weak) id<ZTDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/* 显示 */
- (void)showFrom:(UIView *)from;

/* 销毁 */
- (void)dismiss;

/* 内容 */
@property (nonatomic, strong) UIView *content;

/* 内容控制器 */
@property (nonatomic, strong) UIViewController *contentController;

@end
