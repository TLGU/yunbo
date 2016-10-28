//
//  RootViewController.h
//  Dome
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
@property(strong,nonatomic)UICollectionView *collectionViewDown;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@end
