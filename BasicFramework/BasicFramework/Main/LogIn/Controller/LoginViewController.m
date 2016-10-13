//
//  LoginViewController.m
//  BasicFramework
//
//  Created by 周航 on 16/9/23.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <UMSocialCore/UMSocialCore.h>
@interface LoginViewController ()<UIAlertViewDelegate>
{
    MPMoviePlayerViewController *_movie;
}
    @property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
    @property (strong, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginViewController


- (IBAction)registerAction:(id)sender {
    RegisterViewController *vc=[RegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)forgetPwdAction:(id)sender {
    ForgetPwdViewController *vc=[ForgetPwdViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [ self dismissViewControllerAnimated:YES completion:nil ];
    
    
    
}
#warning test
- (IBAction)loginAction:(id)sender {
 
}

#warning test
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    
    MPMoviePlayerController *player = [aNotification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
   
    [player stop];
    
    [player.view removeFromSuperview];
    
    
    
}



- (IBAction)wxLoginAction:(id)sender {
    
    [self authWithPlatform:UMSocialPlatformType_WechatSession];
}
    
- (IBAction)qqLoginAction:(id)sender {
     [self authWithPlatform:UMSocialPlatformType_QQ];
}
    
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem *item=   [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:item];
    
   
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     self.navigationController.navigationBarHidden=NO;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

//三方平台授权
-(void)authWithPlatform:(UMSocialPlatformType)platformType
{
    
        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WEIXIN_APPID appSecret:WEIXIN_APPKEY redirectURL:@"http://mobile.umeng.com/social"];
    
        [[UMSocialManager defaultManager]  authWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
            
            UMSocialAuthResponse *authresponse = result;
            NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login"
//                                                            message:message
//                                                           delegate:nil
//                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                  otherButtonTitles:nil];
//            [alert show];
            
            NSLog(@"授权信息:%@",message);
            
            [self getUserInfoForPlatform:platformType];
           
        }];
    
    
}



//获取用户信息

// 在需要进行获取用户信息的UIViewController中加入如下代码


- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
}
@end
