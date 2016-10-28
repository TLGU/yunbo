//
//  PuBuLiuLayout.m
//  PuBuLiu
//
//  Created by 王艳清 on 16/7/1.
//  Copyright © 2016年 王艳清. All rights reserved.
//

#import "PuBuLiuLayout.h"

@implementation PuBuLiuLayout {
    // 存放每个item的高度
    NSMutableArray *columnHeightArrM;
    // 存放布局属性
    NSMutableArray *attributedArrM;
}

- (void)setColumnNumber:(NSInteger)columnNumber {
    if (_columnNumber != columnNumber) {
        _columnNumber = columnNumber;
    }
    [self invalidateLayout];
}

- (void)setPadding:(CGFloat)padding {
    if (_padding != padding) {
        _padding = padding;
    }
    [self invalidateLayout];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    if (!UIEdgeInsetsEqualToEdgeInsets(_edgeInsets, edgeInsets)) {
        _edgeInsets = edgeInsets;
    }
    [self invalidateLayout];
}

#pragma mark - 重写的方法

- (void)prepareLayout {
    [super prepareLayout];
    columnHeightArrM = [NSMutableArray arrayWithCapacity:_columnNumber];
    attributedArrM = [NSMutableArray arrayWithCapacity:_columnNumber];
    for (int i = 0; i < _columnNumber; i ++) {
        columnHeightArrM[i] = @(_edgeInsets.top);
    }
    
    // 总宽度
    CGFloat totalWidth = CGRectGetWidth(self.collectionView.frame);
    // item的总宽度
    CGFloat totalItemsWidth = totalWidth - _edgeInsets.left - _edgeInsets.right - _padding * (_columnNumber - 1);
    // 每个item的宽度
    CGFloat itemWidth = totalItemsWidth / _columnNumber;
    // 所有的item个数
    NSInteger itemNumber = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itemNumber; i ++) {
        NSInteger currentColumn = [self minYColumn];
        CGFloat x = _edgeInsets.left + currentColumn * (itemWidth + _padding);
        CGFloat y = [columnHeightArrM[currentColumn] floatValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat itemHeight = 0.0;
        if (_delegate && [_delegate respondsToSelector:@selector(puBuLiuLayoutHeightForItemAtIndex:)]) {
            itemHeight = [_delegate puBuLiuLayoutHeightForItemAtIndex:indexPath];
        }
        CGRect frame = CGRectMake(x, y, itemWidth, itemHeight);
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attribute.frame = frame;
        [attributedArrM addObject:attribute];
        CGFloat newY = y + itemHeight + _padding;
        columnHeightArrM[currentColumn] = @(newY);
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *resultArrM = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attribute in attributedArrM) {
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            [resultArrM addObject:attribute];
        }
    }
    return resultArrM;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return attributedArrM[indexPath.item];
}

- (CGSize)collectionViewContentSize {
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    NSInteger index = [self maxYColumn];
    CGFloat height = [columnHeightArrM[index] floatValue];
    return CGSizeMake(width, height);
}

#pragma mark - 自定义方法

- (NSInteger)maxYColumn {
    __block CGFloat maxHeight = 0.0;
    __block NSInteger maxIndex = 0;
    [columnHeightArrM enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CGFloat heightInArray = [columnHeightArrM[idx] floatValue];
        if (heightInArray > maxHeight ) {
            maxHeight = heightInArray;
            maxIndex = idx;
        }
    }];
    return maxIndex;
}

// 获取y值最小的列
- (NSInteger)minYColumn {
    __block CGFloat minHeight = MAXFLOAT;
    __block NSInteger minColumn = 0;
    [columnHeightArrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat height = [columnHeightArrM[idx] floatValue];
        if (height < minHeight) {
            minHeight = height;
            minColumn = idx;
        }
    }];
    return minColumn;
}




























@end
