//
//  BasicMainTBC.m
//  BasicFramework
//
//  Created by 周航 on 16/9/24.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "BasicMainTBC.h"
#import "RootViewController.h"
#import "BasicMainWebNC.h"
#import "BasicMainNC.h"
@interface BasicMainTBC ()

@end

@implementation BasicMainTBC
    
+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, 1.5);
    
    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildViewControllerWithClassname:[RootViewController description] imagename:@"1--VR专区_03hui" title:@"推荐"];
    [self addChildViewControllerWithClassname:[UIViewController description] imagename:@"11_03" title:@"搜索"];
    [self addChildViewControllerWithClassname:[UIViewController description]imagename:@"22_03" title:@"赚钱"];
    [self addChildViewControllerWithClassname:[UIViewController description] imagename:@"5_03" title:@"我的"];
    
    
}
    
    // 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    BasicMainNC *nav = [[BasicMainNC alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
}

@end
