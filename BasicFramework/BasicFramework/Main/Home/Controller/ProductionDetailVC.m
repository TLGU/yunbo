//
//  ProductionDetailVC.m
//  BasicFramework
//
//  Created by mr_right on 16/10/27.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "ProductionDetailVC.h"
#import "ProductionDetailHeader.h"
#import "ProductionDetailCell.h"
@interface ProductionDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)ProductionDetailHeader *headerView;
@end

@implementation ProductionDetailVC
static NSString *ProductionDetailCellID=@"ProductionDetailCellID";
-(ProductionDetailHeader *)headerView{
    if (!_headerView) {
        _headerView=[ProductionDetailHeader header];
    }
    return _headerView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerNib:[UINib nibWithNibName:@"ProductionDetailCell" bundle:nil] forCellReuseIdentifier:ProductionDetailCellID];
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*2/3)];
        [self.headerView setFrame:view.frame];
        [view addSubview:self.headerView];
        _tableView.tableHeaderView=view;
        _tableView.sectionHeaderHeight=0.1;
         _tableView.sectionFooterHeight=0.1;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView  ;
}
#pragma mark--
#pragma mark--life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}

#pragma mark--
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  ProductionDetailCell *cell=  [tableView dequeueReusableCellWithIdentifier:ProductionDetailCellID forIndexPath:indexPath];
    
    
    return cell;
}
#pragma mark--
#pragma mark--UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenHeight/3.0f;
}
@end
