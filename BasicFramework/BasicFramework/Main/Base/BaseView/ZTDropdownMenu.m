//
//  ZTDropdownMenu.m
//  SinaWeibo
//
//  Created by user on 15/10/16.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import "ZTDropdownMenu.h"

@interface ZTDropdownMenu ()

/**
 *  将来用来显示具体内容的容器
 */
@property (nonatomic, weak) UIImageView *containerView;

@end

@implementation ZTDropdownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

- (UIImageView *)containerView
{
    if (_containerView == nil) {
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}

- (void)showFrom:(UIView *)from
{
    // 获取最上层的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加自己到窗口
    [window addSubview:self];
    // 设置尺寸
    self.frame = window.bounds;
    
    /**
     *  默认情况下，view的frame是以父控件左上角为坐标原点，所以这里需要转换坐标系
     *  [from convertRect:from.bounds toView:window]: 计算控件from在window中的坐标，其中from.bounds是from相对于from的坐标，有一种相对关系。如果toView:nil，nil代表当前空间的主窗口window。
     *  [A convertRect:B toView:C] 等价于 [C convertRect:B toView:A]
     */
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.Cx = CGRectGetMidX(newFrame);
    self.containerView.Y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容的位置
    content.X = 10;
    content.Y = 15;
    
    // 设置灰色的宽度
    self.containerView.Sw = CGRectGetMaxX(content.frame) + 10;
    //设置灰色的高度
    self.containerView.Sh = CGRectGetMaxY(content.frame) + 11;
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    self.content = contentController.view;
}

- (void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
