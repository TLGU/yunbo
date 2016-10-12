//
//  TestViewController.m
//  BasicFramework
//
//  Created by 周航 on 16/10/12.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "TestViewController.h"
#import "UMSocialUIManager.h"
#import "WXApiRequestHandler.h"



@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (IBAction)loginTest:(id)sender {
     [[NSNotificationCenter defaultCenter] postNotificationName:LoginStatus_Changed object:nil];
}
- (IBAction)payTest:(id)sender {
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxb4ba3c02aa476ea1" appSecret:WEIXIN_APPKEY redirectURL:@"http://mobile.umeng.com/social"];
    
    [WXApiRequestHandler jumpToBizPay];
}

- (IBAction)zfbPayTest:(id)sender {
    
    
}



- (IBAction)shareTest:(id)sender {
    //显示分享面板
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType platformType) {
        
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
}




//第三方平台分享
//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"网页分享测试01010101" descr:@"点击跳转百度网页" thumImage:[UIImage imageNamed:@"haowan"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://www.baidu.com";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            [SVProgressHUD showErrorWithStatus:@"分享失败！"];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                NSLog(@"response message is %@",resp.message);
                //第三方原始返回的数据
                NSLog(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                NSLog(@"response data is %@",data);
            }
        }
        [SVProgressHUD showSuccessWithStatus:@"分享成功！"];
    }];
}
@end
