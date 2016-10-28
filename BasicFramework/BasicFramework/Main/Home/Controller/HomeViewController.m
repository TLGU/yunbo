


//
//  HomeViewController.m
//  BasicFramework
//
//  Created by mr_right on 16/10/25.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "HotCell.h"
#import "ZuoPinTableViewCell.h"
#import "ProductionDetailVC.h"
#import "ProductionListVC.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView;

@property(strong,nonatomic)HomeHeaderView *headerView;


@end

@implementation HomeViewController
static NSString * hotCellId=@"HotCellID";
static NSString * zuopinCellId=@"ZuoPinCellID";
#pragma mark--
#pragma mark--getter and setter

-(HomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[HomeHeaderView headerView];
        [_headerView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*3/7)];
        
        
        
    }
    return _headerView;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView=[[UITableView alloc]  initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:UITableViewStyleGrouped];
        
        _tableView.delegate=self;
        
        _tableView.dataSource=self;
        
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
        
        UIView *view=  [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*3/7)];
        
        
        [view addSubview:self.headerView];
        
        _tableView.tableHeaderView=view;
        
        _tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HotCell class]) bundle:nil] forCellReuseIdentifier:hotCellId];
        
         [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZuoPinTableViewCell class]) bundle:nil] forCellReuseIdentifier:zuopinCellId];
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        
    }
    return _tableView;
}


#pragma mark--
#pragma mark--life cycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden=YES;
    
    [self.view addSubview:self.tableView];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
    
}



#pragma mark--
#pragma mark--UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return 10;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        HotCell *cell=  [tableView dequeueReusableCellWithIdentifier:hotCellId forIndexPath:indexPath];
        return cell;
    }else{
    
        ZuoPinTableViewCell *cell=  [tableView dequeueReusableCellWithIdentifier:zuopinCellId forIndexPath:indexPath];
        return cell;
    }

}


#pragma mark--
#pragma mark--UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    ProductionListVC *vc=[ProductionListVC new];
    [self pushVc:vc];
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    view.backgroundColor=[UIColor blackColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }else{
        return 200;
    }

}


 
@end
