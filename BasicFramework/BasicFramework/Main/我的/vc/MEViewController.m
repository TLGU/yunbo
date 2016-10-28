//
//  MEViewController.m
//  BasicFramework
//
//  Created by mr_right on 16/10/28.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "MEViewController.h"
#import "MECell.h"
#import "MEHeaderView.h"
@interface MEViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)MEHeaderView *headerView;
@end

@implementation MEViewController
static NSString *MECellID=@"MECellID";
#pragma mark--
#pragma mark--life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [self.view addSubview:self.tableView];
}

#pragma mark--
#pragma mark--getter and setter
-(MEHeaderView *)headerView{
    if (!_headerView) {
        _headerView=[MEHeaderView header];
        [_headerView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*4/9)];
    }
    return _headerView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
        
        NSMutableArray *arr0=[NSMutableArray array];
        NSMutableArray *arr1=[NSMutableArray array];
        NSMutableArray *arr2=[NSMutableArray array];
        
        NSMutableDictionary *dic00=[NSMutableDictionary dictionary];
        dic00[@"icon"]=@"me_production_qiang";
        dic00[@"name"]=@"作品墙";
        [arr0 addObject:dic00];
        
        NSMutableDictionary *dic10=[NSMutableDictionary dictionary];
        dic10[@"icon"]=@"me_mingpian";
        dic10[@"name"]=@"我的名片";
        [arr1 addObject:dic10];
        NSMutableDictionary *dic11=[NSMutableDictionary dictionary];
        dic11[@"icon"]=@"me_comment";
        dic11[@"name"]=@"我的评论";
        [arr1 addObject:dic11];
        
        NSMutableDictionary *dic20=[NSMutableDictionary dictionary];
        dic20[@"icon"]=@"me_about";
        dic20[@"name"]=@"关于多好玩";
        [arr2 addObject:dic20];
        NSMutableDictionary *dic21=[NSMutableDictionary dictionary];
        dic21[@"icon"]=@"me_fankui";
        dic21[@"name"]=@"意见反馈";
        [arr2 addObject:dic21];
        
        [_dataArray addObject:arr0];
        [_dataArray addObject:arr1];
        [_dataArray addObject:arr2];
        
    }
    return _dataArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MECell class]) bundle:nil
                                 ] forCellReuseIdentifier:MECellID];
        
        UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*4/9)];
        [header addSubview:self.headerView];
        _tableView.tableHeaderView=header;
    }
    return _tableView;
}
#pragma mark--
#pragma mark--UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray[section] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *marr=  self.dataArray[indexPath.section];
    NSMutableDictionary *mdic= marr[indexPath.row];
    NSString *icon= mdic[@"icon"];
    NSString *name= mdic[@"name"];
    MECell *cell=  [tableView dequeueReusableCellWithIdentifier:MECellID forIndexPath:indexPath];
    cell.imageView.image=[UIImage imageNamed:icon];
    cell.textLabel.text=name;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (kScreenHeight>=568) {
        return 53;
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (kScreenHeight>=568) {
        return 8;
    }
    return 2.5f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (kScreenHeight>=568) {
        return 8;
    }
    return 2.5f;
}
@end
