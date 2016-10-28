//
//  ToViewController.m
//  PuBuLiu
//
//  Created by 王艳清 on 16/7/1.
//  Copyright © 2016年 王艳清. All rights reserved.
//

#import "ToViewController.h"
#import "CustomTransition.h"

@interface ToViewController ()

@end

@implementation ToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(10, 74, CGRectGetWidth(self.view.frame) - 20, 400)];
    _topView.backgroundColor = self.color;
    [self.view addSubview:_topView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"ss");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 导航控制器的代理

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return [[CustomTransition alloc] initWithTransitionType:operation == UINavigationControllerOperationPush? push :pop];
}

@end
