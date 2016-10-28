//
//  MEHeaderView.m
//  BasicFramework
//
//  Created by mr_right on 16/10/28.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "MEHeaderView.h"

@implementation MEHeaderView

+(instancetype)header{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)loginAction:(id)sender {
    [[NSNotificationCenter defaultCenter ] postNotificationName:LoginStatus_Changed object:nil];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}
@end
