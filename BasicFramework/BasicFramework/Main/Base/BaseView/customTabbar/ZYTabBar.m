//
//  ZYTabBar.m
//  自定义tabbarDemo
//
//  Created by tarena on 16/7/1.
//  Copyright © 2016年 张永强. All rights reserved.
//

#import "ZYTabBar.h"
#import "UIView+LBExtension.h"
#import <objc/runtime.h>

#define ZYMagin 10

@interface ZYTabBar ()<ZYPathButtonDelegate>
@property (nonatomic , strong)ZYPathButton *plusBtn;
@end

@implementation ZYTabBar
//对按钮的一些基本设置
- (void)setUpPathButton:(ZYPathButton *)pathButton {
    pathButton.delegate = self;
    pathButton.bloomRadius = self.bloomRadius;
    pathButton.allowCenterButtonRotation = self.allowCenterButtonRotation;
    pathButton.bottomViewColor = [UIColor clearColor];
    pathButton.bloomDirection = kZYPathButtonBloomDirectionTop;
    pathButton.basicDuration = self.basicDuration;
    pathButton.bloomAngel = self.bloomAngel;
    pathButton.allowSounds = NO;
}
- (void)drawRect:(CGRect)rect {
   self.plusBtn = [[ZYPathButton alloc]initWithCenterImage:[UIImage imageNamed:@"chooser-button-tab"]highlightedImage:[UIImage imageNamed:@"chooser-button-tab"]];
    self.plusBtn.delegate = self;
    [self setUpPathButton:self.plusBtn];
//    self.plusBtn.ZYButtonCenter = CGPointMake(self.centerX, self.superview.height - self.height * 0.5 - 2 *ZYMagin );
   self.plusBtn.ZYButtonCenter = CGPointMake(self.centerX, self.centerY );
    
    [self.plusBtn addPathItems:self.pathButtonArray];
    //必须加到父视图上
    [self.superview addSubview:self.plusBtn];
    UILabel *label = [[UILabel alloc]init];
    if (_title != nil) {
        label.text = _title;
    }else {
        label.text = @"中间";
    }
    label.font = [UIFont systemFontOfSize:13];
    [label sizeToFit];
    label.textColor = [UIColor grayColor];
    label.centerX = _plusBtn.centerX;
    label.centerY = CGRectGetMaxY(_plusBtn.frame) + ZYMagin;
    [self.superview addSubview:label];
}
//重新绘制按钮
- (void)layoutSubviews {
    [super layoutSubviews];
     self.backgroundColor = [UIColor whiteColor];
    //系统自带的按钮类型是UITabBarButton,找出这些类型的按钮,然后重新排布位置 ,空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
           //每一个按钮的宽度 == tabbar的五分之一
            btn.width = self.width * 0.2;
            btn.x = btn.width * btnIndex;
            btnIndex ++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    
}
- (void)pathButton:(ZYPathButton *)ZYPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    if ([self.delegate respondsToSelector:@selector(pathButton:clickItemButtonAtIndex:)]) {
        [self.delegate pathButton:self clickItemButtonAtIndex:itemButtonIndex];
    }
}


@end















