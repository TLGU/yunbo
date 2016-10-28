//
//  RegisterViewController.m
//  BasicFramework
//
//  Created by 周航 on 16/9/24.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "RegisterViewController.h"
#import "AccountService.h"
#import "MD5Encryption.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *ranCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWord_OKTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"手机注册";
    
    
}

- (IBAction)getRanCodeAction:(id)sender
{
    
    
    
    if (self.phoneTextField.text.length<11)
    {
        [SVProgressHUD showErrorWithStatus:@"请核实您的手机号码."];
        return;
    }
    
    [AccountService getPhoneRanCodeWithPhone:self.phoneTextField.text isUser:NO target:self sucess:^(id value) {
        [self countDownWithButton:sender];
       
    } failure:^(id value) {
        
    }];
    
    
    
    
    
}



- (IBAction)registerAction:(id)sender

{
    
    
    
    if (self.phoneTextField.text.length<11) {
        [SVProgressHUD showErrorWithStatus:@"请核实您的手机号码."];
        return;
    }
    if (self.ranCodeTextField.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (self.passWordTextField.text.length<6||self.passWordTextField.text.length>16)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入6-16位的字母,符号或数字的组合密码"];
        return;
    }
//    if (self.passWord_OKTextField.text.length<1) {
//        [SVProgressHUD showErrorWithStatus:@"请再次确认密码"];
//        return;
//    }
    
    
    //    NSString *userPwd=[MD5Encryption md5by32:self.passWordTextField.text];
    //
    //    NSString *userPwd_Ok=[MD5Encryption md5by32:self.passWord_OKTextField.text];
    
    [AccountService registerWithPhone:self.phoneTextField.text
                             randCode:self.ranCodeTextField.text
                              userPwd:self.passWordTextField.text
                           userPwd_ok:self.passWordTextField.text
                               target:self
                               sucess:^(id value)
     {
         
         [self dismissViewControllerAnimated:YES completion:nil];
     }
                              failure:^(id value)
     {
         
     }];
    
    
    
    
}


-(void)countDownWithButton:(UIButton *)button
{
    __block int timeout=30; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                
//                button.backgroundColor = base_control_color;
                
                
                
                button.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            //            int minutes = timeout / 60;
            
            int seconds = timeout % 59;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                //                NSLog(@"____%@",strTime);
                
                [button setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                
//                button.backgroundColor = [UIColor grayColor];
                
                button.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    dispatch_resume(_timer);
    
    
}

@end
