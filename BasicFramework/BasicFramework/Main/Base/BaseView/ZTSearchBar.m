//
//  ZTSearchBar.m
//  SinaWeibo
//
//  Created by user on 15/10/15.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import "ZTSearchBar.h"

@implementation ZTSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(300, 30);
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入查询条件";
        // 提前在Xcode上设置图片中间拉伸
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.size = CGSizeMake(30, 30);
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}


@end
