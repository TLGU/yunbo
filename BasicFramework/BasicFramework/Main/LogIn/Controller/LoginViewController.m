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

@interface LoginViewController ()
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
   
}
    
- (IBAction)qqLoginAction:(id)sender {
    
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



@end
