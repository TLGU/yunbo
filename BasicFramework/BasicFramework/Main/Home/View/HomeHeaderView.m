//
//  HomeHeaderView.m
//  BasicFramework
//
//  Created by mr_right on 16/10/27.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "HomeHeaderView.h"
#import "LBBanner.h"
@interface HomeHeaderView ()<LBBannerDelegate>
@property (weak, nonatomic) IBOutlet UIView *right4View;

@end

@implementation HomeHeaderView
+(instancetype)headerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
//    [self loadNetImageSystemPageControl];
    
    
    
    
    
}

/**
 *  加载网络图片、系统PageControl、不设置标题
 */

- (void)loadNetImageSystemPageControl
{
    NSArray * imageURLArray = @[@"http://i4.piimg.com/567571/5bb2bd5f3d9ed1c9.jpg", @"http://i4.piimg.com/567571/0747e4dc1a1e5cc2.jpg", @"http://i4.piimg.com/567571/2245e6c27d0435dd.jpg", @"http://i4.piimg.com/567571/740fdc787945b551.jpg"];
    LBBanner * banner = [[LBBanner alloc] initWithImageURLArray:imageURLArray andFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,( kScreenHeight*3/7)*4/7)];
    banner.delegate = self;
    banner.pageTurnTime = 3.0;
    
    [self.adView addSubview:banner];
}

- (void)banner:(LBBanner *)banner didClickViewWithIndex:(NSInteger)index {
    NSLog(@"didClickViewWithIndex:%ld", index);
}

- (void)banner:(LBBanner *)banner didChangeViewWithIndex:(NSInteger)index {
    NSLog(@"didChangeViewWithIndex:%ld", index);
}

@end
