//
//  ZTTabBar.m
//  SinaWeibo
//
//  Created by user on 15/10/16.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import "ZTTabBar.h"

@interface ZTTabBar ()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation ZTTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc] init];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"add_press"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"add_press"] forState:UIControlStateHighlighted];
        
        
        [plusBtn setImage:[UIImage imageNamed:@"add_press"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"add_press"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    
    
    
    
    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)plusBtnClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

/**
 *  想要重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布。
 */



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.Cx = self.Sw*0.5;
    self.plusBtn.Cy = self.Sh*0.5;
//    self.plusBtn.Cy = 0;
    NSLog(@"%lf,%lf",self.Sw,self.Sh);
    // 2.设置其他tabbarButton的frame
    CGFloat tabBarButtonW = self.Sw / 5;
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置x
            child.X = tabBarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.Sw = tabBarButtonW;
            // 增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}

@end
