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
#import "ZYTabBar.h"



@interface BasicMainTBC ()<ZYTabBarDelegate>

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
    
    
    [self addChildViewControllerWithClassname:[RootViewController description] imagename:@"1--VR专区_03hui" title:@"首页"];
    [self addChildViewControllerWithClassname:[UIViewController description] imagename:@"11_03" title:@"动态"];
    [self addChildViewControllerWithClassname:[UIViewController description]imagename:@"22_03" title:@"商城"];
    [self addChildViewControllerWithClassname:[UIViewController description] imagename:@"5_03" title:@"我的"];
    
    
    
    [self configureZYPathButton];
    
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


-(UIImage *)getBackImg{
    return  [UIImage createImageWithColor:[UIColor blackColor]];
}

- (void)configureZYPathButton
{
    ZYTabBar *tabBar = [ZYTabBar new];
    tabBar.delegate = self;
    ZYPathItemButton *itemButton_1 = [[ZYPathItemButton alloc] initWithImage:[UIImage imageNamed:@"chooser-moment-icon-music"]
                                                            highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"]backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]
                                      
                                                  backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    
    ZYPathItemButton *itemButton_2 = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-place"]highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"]backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    
    ZYPathItemButton *itemButton_3 = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-camera"]highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"]backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
    
    ZYPathItemButton *itemButton_4 = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-thought"]highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"]backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    
   
    
    
    ZYPathItemButton *itemButton_5 = [[ZYPathItemButton alloc]initWithImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"]highlightedImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"]backgroundImage:[UIImage imageNamed:@"chooser-moment-button"]backgroundHighlightedImage:[UIImage imageNamed:@"chooser-moment-button-highlighted"]];
    tabBar.pathButtonArray = @[itemButton_1 , itemButton_2 , itemButton_3, itemButton_4 , itemButton_5];
    tabBar.basicDuration = 0.5;
    tabBar.allowSubItemRotation = YES;
    tabBar.title = @"";
    tabBar.bloomRadius = 100;
    tabBar.allowCenterButtonRotation = YES;
    tabBar.bloomAngel = 100;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}
#pragma mark--ZYTabBarDelegate
- (void)pathButton:(ZYPathButton *)ZYPathButton clickItemButtonAtIndex:(NSUInteger)itemButtonIndex {
    NSLog(@" 点中了第%ld个按钮" , itemButtonIndex);
    

    
    if (itemButtonIndex==0) {
        
         [[NSNotificationCenter defaultCenter] postNotificationName:LoginStatus_Changed object:nil];
    }else{
        
       
    }
    
    
    
}




@end
