//
//  RootViewController.m
//  Dome
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "RootViewController.h"
#import "YSLContainerViewController.h"
#import "WaterFlowLayout.h"
#import "RootCollectionViewCell.h"
#import "IndexCollectionReusableViewHeader.h"
#import "PuBuLiuLayout.h"
#import "ToViewController.h"
#define TopItemWidth (kScreenWidth-22)/3.0f
#define TopItemHeight 100
@interface RootViewController ()<PuBuLiuLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIView *topView;
@property(strong,nonatomic)UIScrollView *scrollView;


@end
@implementation RootViewController

static NSString *reuseIdentifierForRootCell=@"reuseIdentifierRootViewController";
//SupplementaryViewOf
static NSString *reuseIdentifierForSupplementaryViewOfHeader=@"reuseIdentifierForSupplementaryViewOfHeader";
#pragma mark--getter and setter --getter and setter
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.topView.Sh+self.collectionViewDown.Sh)];
        [view addSubview:self.topView];
        [view addSubview:self.collectionViewDown];
        [_scrollView addSubview:view];
       
        _scrollView.contentSize=CGSizeMake(kScreenWidth, self.topView.Sh+self.collectionViewDown.Sh);
    }
    return _scrollView;
}
-(UICollectionView *)collectionViewDown
{
    if (!_collectionViewDown)
    {
        PuBuLiuLayout *layout = [[PuBuLiuLayout alloc] init];
        layout.columnNumber = 2;
        layout.delegate = self;
        layout.padding = 5;
        layout.edgeInsets = UIEdgeInsetsMake(5, 5, 20, 5);
        
        
        _collectionViewDown=[[UICollectionView alloc] initWithFrame: CGRectMake(0, self.topView.Sh, kScreenWidth, kScreenHeight)  collectionViewLayout:layout];
        
        [_collectionViewDown registerNib:[UINib nibWithNibName:@"RootCollectionViewCell" bundle:nil]
              forCellWithReuseIdentifier:reuseIdentifierForRootCell];
        
        [_collectionViewDown registerNib:[UINib nibWithNibName:@"IndexCollectionReusableViewHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierForSupplementaryViewOfHeader];
        
        
       _collectionViewDown.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);

        _collectionViewDown.scrollIndicatorInsets=_collectionViewDown.contentInset;
        
        _collectionViewDown.dataSource=self;
        
        _collectionViewDown.delegate=self;
        
        
        _collectionViewDown.backgroundColor=[UIColor whiteColor];
        
        
    }
    
    return _collectionViewDown;
}


-(UIView *)topView{
    if (!_topView) {
        _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.8-49)];
        _topView.backgroundColor=[UIColor cyanColor];
    }
    return _topView;
}

#pragma mark--life cycle --life cycle --life cycle

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y>0) {
        [UIView animateWithDuration:1.0f animations:^{
            self.scrollView.contentOffset=CGPointMake(0, self.topView.Sh);
            
        }completion:^(BOOL finished) {
            
        }];
        
    }else{
        [UIView animateWithDuration:1.0f animations:^{
           self.scrollView.contentOffset=CGPointMake(0, 0);
        }completion:^(BOOL finished) {
            
        }];
        
    }
    NSLog(@"--->%.2f",scrollView.contentOffset.y);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view addSubview:self.scrollView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
}
#pragma mark--UICollectionViewDataSource--UICollectionViewDataSource



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(kScreenWidth, 150);
    }else{
        return CGSizeZero;
    }
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 1;
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
        return 10;
  
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RootCollectionViewCell *cell =   [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierForRootCell forIndexPath:indexPath];
    
    cell.backgroundColor=DMRandColor;
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark--uicollectionviewdelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ToViewController *toVC = [[ToViewController alloc] init];
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    toVC.color = cell.backgroundColor;
    self.currentIndexPath = indexPath;
    self.navigationController.delegate = toVC;
    [self.navigationController pushViewController:toVC animated:YES];
}


#pragma mark - layout的代理事件

- (CGFloat)puBuLiuLayoutHeightForItemAtIndex:(NSIndexPath *)index
{
    return arc4random_uniform(80) + 120;
}


    
    
    
    
@end
