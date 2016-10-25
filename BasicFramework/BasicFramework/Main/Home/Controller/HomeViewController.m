


//
//  HomeViewController.m
//  BasicFramework
//
//  Created by mr_right on 16/10/25.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)SDCycleScrollView *cycleScrollView3;



@end

@implementation HomeViewController

#pragma mark--
#pragma mark--getter and setter


-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView=[[UITableView alloc]  initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}


#pragma mark--
#pragma mark--life cycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
//    [self.view addSubview:self.tableView];
    
    self.navigationController.navigationBarHidden=YES;
    
    [self setupAdView];
    
    
//    self.tableView.tableHeaderView=self.cycleScrollView3;
    
    
//    [self.view addSubview:self.cycleScrollView3];
}


-(void)setupAdView
{
    
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 180);
    [self.view addSubview:demoContainerView];
    
    
    
     CGFloat w = self.view.bounds.size.width;
    
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[@"http://pic24.nipic.com/20121003/10754047_140022530392_2.jpg", @"http://img15.3lian.com/2015/a1/13/d/17.jpg", @"http://pic36.nipic.com/20131022/7786988_135813187182_2.jpg"];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        ];
    
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    self.cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    self.cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//    self.cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    self.cycleScrollView3.titlesGroup = titles;
    self.cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
    self.cycleScrollView3.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView3.clickItemOperationBlock = ^(NSInteger index) {
        NSLog(@">>>>>  %ld", (long)index);
    };
    
    [demoContainerView addSubview:self.cycleScrollView3];
    
    
    
    
    
    
}


#pragma mark--
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}
#pragma mark--
#pragma mark--UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}



 
 // 滚动到第几张图回调
// - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
// {
// NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
// }

 
@end
