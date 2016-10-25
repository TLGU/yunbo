//
//  ForgetPwdViewController.m
//  BasicFramework
//
//  Created by 周航 on 16/9/24.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "AccountService.h"
@interface ForgetPwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *ranCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwd_okTextField;

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"忘记密码";
}

- (IBAction)getRanCodeAction:(id)sender
{
    
    if (self.phoneTextField.text.length<11)
    {
        [SVProgressHUD showErrorWithStatus:@"请核实您的手机号码正确性."];
        return;
    }
    [AccountService getPhoneRanCodeWithPhone:self.phoneTextField.text
                                      isUser:YES
                                      target:self sucess:^(id value) {
                                          
                                          [SVProgressHUD  showSuccessWithStatus:value];
                                          
                                          [self countDownWithButton:sender];
                                          
                                      } failure:nil];
}

- (IBAction)submitAction:(id)sender
{
    if (self.phoneTextField.text.length<11)
    {
        [SVProgressHUD showErrorWithStatus:@"请核实您的手机号码正确性."];
        return;
    }
    if (self.ranCodeTextField.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    if (self.pwdTextField.text.length<6) {
        [SVProgressHUD showErrorWithStatus:@"密码必须为6-16位的字母或数字的组合"];
        return;
    }
    if (![self.pwd_okTextField.text isEqualToString:self.pwdTextField.text])
    {
        [SVProgressHUD showErrorWithStatus:@"两次密码输入不一致!"];
        return;
    }
    
    [AccountService resetPwdWithPhone:self.phoneTextField.text
                             randCode:self.ranCodeTextField.text
                              userPwd:self.pwdTextField.text
                           userPwd_ok:self.pwd_okTextField.text
                               target:self sucess:^(id value)
     {
         
         //        [SVProgressHUD showSuccessWithStatus:value];
         
         [self dismissViewControllerAnimated:YES completion:nil];
         
     } failure:nil];
    
    
    
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
