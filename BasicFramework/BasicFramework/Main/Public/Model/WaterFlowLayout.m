//
//  WaterFlowLayout.m
//  05-瀑布流基本实现
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "WaterFlowLayout.h"
//#import "ShopModel.h"

@interface WaterFlowLayout()

// 保存每一列最大的Y值
@property (nonatomic, strong) NSMutableArray *maxYArray;

@end

// 最大列数
static    NSInteger maxColumn = 2;

@implementation WaterFlowLayout


- (NSMutableArray *)maxYArray {
    if (nil == _maxYArray) {
        _maxYArray = [NSMutableArray array];
    }
    return _maxYArray;
}


- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

// 准备布局的时候调用 , 当布局刷新(改变)
- (void)prepareLayout {
    [super prepareLayout];
    
    
}

// 当可见范围发生变化的时候,  就会重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

#pragma mark -
#pragma mark - 反回的是每一个cell的属性
// 对每一个cell的属性进行设置, frame(x,y,width, height)
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
   
        
    
    // 确定最大的列数
//    NSInteger maxColumn = 3;
    
    // 确定行间距, 列间距
    CGFloat columnMargin = 3;
    CGFloat rowMargin = 3;
    
    // 确定组的内间距
    UIEdgeInsets sectionInsets = UIEdgeInsetsMake(10, 0, 10, 0);
    
    
    // 取出collectionView 的 size
    CGSize collectionViewSize = self.collectionView.frame.size;
    
    // 确定cell 的宽度
    CGFloat itemWidth = (collectionViewSize.width - sectionInsets.left - sectionInsets.right - (maxColumn - 1) * columnMargin) / maxColumn;
    
    // 确定cell的高度
#warning 计算cell的高度待定
    // 取出对应到 indexPath.item , imageArray 的对象
//    ShopModel *shopModel = _imageArray[indexPath.row];
    // itemW/itemH = w/h
//    CGFloat itemHeight = itemWidth * shopModel.h / shopModel.w;
    
    CGFloat itemHeight = [self.delegate waterFlowLayout:self withIndexPath:indexPath andItemWidth:itemWidth];
    
    // 确定cell 的 x 和  y
#warning x, y 待计算
   
    
    // 找到 最短的最大Y值
    CGFloat minMaxY = [self.maxYArray[0] doubleValue];
    
    // 定义 最短的列
    NSInteger minColumn = 0;
    
    for (int i = 1; i < maxColumn; i++) {
        // 取出数组中的Y值
        CGFloat arrayY = [self.maxYArray[i] doubleValue];
        
        if (minMaxY > arrayY) {
            // 确定最短的最大Y值
            minMaxY = arrayY;
            
            minColumn = i;
        }
    }
    
    CGFloat itemX = minColumn * itemWidth + minColumn * columnMargin + sectionInsets.left;
    
    
    CGFloat itemY = minMaxY + rowMargin;
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    // 记录 最大Y值
    self.maxYArray[minColumn] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
    
    
    
    
}


#pragma mark -
#pragma mark -  反回可见区域的cell属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 在每次调用这个方法的时候, 最好把 maxYArray 给清空掉
    [self.maxYArray removeAllObjects];
    
    // 对数组做初始化
    for (int i = 0; i <  maxColumn; i++) {
        [self.maxYArray addObject:@0];
    }
    
    // 实例化一个可变数组
    NSMutableArray *itemArray = [NSMutableArray array];
    
    
   
    
    
    // 取出当前有多少个cell, 反回第1组有多少个cell
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:1];
    
    for (int i = 0; i < itemCount; i++) {
        // 创建一个 indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:1];
        
        // 调用 layoutAttributesForItemAtIndexPath: 返回是对应到indexPath 中cell的属性
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        // 把cell的属性放到  可变数组中
        [itemArray addObject:attri];
    }
    
    
    
    
    return itemArray;
}

- (CGSize)collectionViewContentSize {
    
    CGFloat maxY = 0;
    
    if (self.maxYArray.count) {
        maxY = [self.maxYArray[0] doubleValue];
        
        for (int i = 1; i < maxColumn; i++) {
            CGFloat arryY = [self.maxYArray[i] doubleValue];
            
            if (maxY < arryY) {
                maxY = arryY;
            }
        }
    }
    
    return CGSizeMake(0, maxY + 10);
}

@end
