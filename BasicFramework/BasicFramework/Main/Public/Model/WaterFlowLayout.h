//
//  WaterFlowLayout.h
//  05-瀑布流基本实现
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

// item的高度
- (CGFloat)waterFlowLayout:(WaterFlowLayout *)waterFlowLayout withIndexPath:(NSIndexPath *)indexPath andItemWidth:(CGFloat)width;


@end

@interface WaterFlowLayout : UICollectionViewFlowLayout

//@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, weak) id<WaterFlowLayoutDelegate> delegate;

@end
