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
<<<<<<< HEAD
#import "HomeViewController.h"
#import "UIImage+Image.h"
#import "ZTTabBar.h"
@interface BasicMainTBC ()<ZTTabBarDelegate>
=======
#import "ZYTabBar.h"

#import "TestViewController.h"

@interface BasicMainTBC ()<ZYTabBarDelegate>
>>>>>>> origin/branch-1

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
    
    
    
  
    
    
//    self.tabBar.translucent = NO;
//    self.tabBar.backgroundImage = [UIImage imageNamed:@"bar"];
//    self.tabBar.tintColor = [UIColor blackColor];
    
    
    [self setChildVC];
    
    [self setUpTabbar];
    
}
- (void)setUpTabbar {
    
    ZTTabBar *tabBar = [[ZTTabBar alloc] init];
    
    tabBar.delegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    
    [self setValue:tabBar forKey:@"tabBar"];
    
}








- (void)setChildVC {
    
    
    [self addChildViewControllerWithClassname:[HomeViewController description] imagename:@"home" title:@"首页"];
    
    [self addChildViewControllerWithClassname:[UIViewController description] imagename:@"search" title:@"搜索"];
    
    [self addChildViewControllerWithClassname:[UIViewController description]imagename:@"guanzhu" title:@"关注"];
    
    [self addChildViewControllerWithClassname:[UIViewController description] imagename:@"me" title:@"我的"];
    
    
    
}
<<<<<<< HEAD
    // 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
=======
#pragma mark--ZYTabBarDelegate
- (void)pathButton:(ZYPathButton *)ZYPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex
{
    NSLog(@" 点中了第%ld个按钮" , itemButtonIndex);
    if (itemButtonIndex==0)
    {
        TestViewController *vc=[TestViewController new];
        UINavigationController *nav=  (UINavigationController *)self.selectedViewController;
        [nav pushViewController:vc animated:YES];
    }
    
>>>>>>> origin/branch-1
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    BasicMainNC *nav = [[BasicMainNC alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_press"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
}


-(UIImage *)getBackImg
{
    return  [UIImage createImageWithColor:[UIColor blackColor]];
}
#pragma ZTTabBarDelegate
/**
 *  加号按钮点击
 */
- (void)tabBarDidClickPlusButton:(ZTTabBar *)tabBar
{
//    UIViewController *vc = [[UIViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

@end
