//
//  HotCell.m
//  BasicFramework
//
//  Created by mr_right on 16/10/27.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HotCell.h"

#import "HotCollectionViewCell.h"
#define itemW  (kScreenWidth-80)*0.5
#define itemH itemW *1.5
@interface HotCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *collectionView;
@end

@implementation HotCell
static NSString *hotCollectionViewCellID=@"hotCollectionViewCellID";
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize=CGSizeMake(itemW, itemH);
        layout.sectionInset=UIEdgeInsetsMake(0, 10, 0, 10);
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing=15;
        layout.minimumInteritemSpacing=15;
        
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HotCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:hotCollectionViewCellID];
        
        _collectionView.backgroundColor=kRGB(245, 245, 245);
        
    }
    return _collectionView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView addSubview:self.collectionView];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
    }
    
    HotCollectionViewCell *cell=   [collectionView dequeueReusableCellWithReuseIdentifier: hotCollectionViewCellID forIndexPath:indexPath];
    
    return cell;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
