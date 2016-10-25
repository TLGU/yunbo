//
//  AccountService.m
//  BasicFramework
//
//  Created by mr_right on 16/10/20.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "AccountService.h"
#import "MD5Encryption.h"
@implementation AccountService
//获取手机验证码
+(void)getPhoneRanCodeWithPhone:(NSString *)phone
                         isUser:(BOOL)bo
                         target:(UIViewController *)targetVC
                         sucess:(void (^)(id value))sucessBlock
                        failure:(void (^)(id value))failureBlock
{
    if (!phone)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"phone"]=phone;
    NSString *urlStr=@"";
    if (bo) {
        urlStr=URL_For_UserRandCode;
        dic[@"username"]=phone;
        [dic removeObjectForKey:@"phone"];
    }else{
        urlStr=URL_For_RandCode;
        
    }
    [SVProgressHUD show];
    [[NetWorkManager sharedInstance] requestDataForGETWithURL:urlStr
                                                   parameters:dic
                                                   Controller:targetVC
                                                      success:^(id responseObject)
     {
         
//         [SVProgressHUD dismiss];
         if (sucessBlock)
         {
             NSString *rand=   [responseObject objectForKey:@"rand"];
             NSString *message=  [responseObject objectForKey:@"message"];
             NSLog(@"验证码是:%@",rand);
             sucessBlock(message);
             [SVProgressHUD showSuccessWithStatus:message];
             
         }
     } failure:^(NSError *error)
     {
//         [SVProgressHUD dismiss];
         if (failureBlock)
         {
             failureBlock(error);
         }
     }];
    
    
    
}

//手机注册

+(void)registerWithPhone:(NSString *)phone
                randCode:(NSString *)randCode
                 userPwd:(NSString *)userPwd
              userPwd_ok:(NSString *)userPwd_ok
                  target:(UIViewController *)targetVC
                  sucess:(void (^)(id value))sucessBlock
                 failure:(void (^)(id value))failureBlock
{
    
    if (!phone.length||!randCode.length||!userPwd.length||!userPwd_ok.length)
    {
        [SVProgressHUD showErrorWithStatus:@"参数不完整"];
        return;
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"username"]=phone;
    params[@"randCode"]=randCode;
    params[@"userpwd"]=userPwd;
    params[@"userpwd_ok"]=userPwd_ok;
    
    [SVProgressHUD show];
    [[NetWorkManager sharedInstance] requestDataForPOSTWithURL:URL_For_Register
                                                    parameters:params
                                                    Controller:targetVC
                                                       success:^(id responseObject)
     {
         
         [SVProgressHUD showSuccessWithStatus:@"注册成功."];
         
         NSString *key= [responseObject objectForKey:@"key"];
         
         
         [[NSUserDefaults standardUserDefaults] setObject:key forKey:user_name_key];
         
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         if (sucessBlock)
         {
             sucessBlock(responseObject);
             
         }
         
     } failure:^(NSError *error)
     {
         
         if (failureBlock)
         {
             failureBlock(error);
         }
     }];
    
    
    
    
}
//第三方平台登录

+(void)thirdLoginWithNickname:(NSString *)nickname
                   headimgurl:(NSString *)headimgurl
                          sex:(NSString *)sex
                third_user_id:(NSString *)third_user_id
              third_user_type:(NSString *)third_user_type
                       target:(UIViewController *)targetVC
                       sucess:(void (^)(id value))sucessBlock
                      failure:(void (^)(id value))failureBlock
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"nickname"]=nickname;
    params[@"headimgurl"]=headimgurl;
    params[@"sex"]=sex;
    params[@"third_user_id"]=third_user_id;
    params[@"third_user_type"]=third_user_type;
    [SVProgressHUD show];
    [[NetWorkManager sharedInstance] requestDataForPOSTWithURL:URL_For_Third_Login
                                                    parameters:params
                                                    Controller:targetVC
                                                       success:^(id responseObject)
     {
         
         NSString * message=  [responseObject objectForKey:@"message"];
         
         [SVProgressHUD showSuccessWithStatus:message];
         
         NSString *key= [responseObject objectForKey:@"key"];
         
         
         [[NSUserDefaults standardUserDefaults] setObject:key forKey:user_name_key];
         
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         if (sucessBlock)
         {
             sucessBlock(responseObject);
             
         }
         
     } failure:^(NSError *error)
     {
         
         if (failureBlock)
         {
             failureBlock(error);
         }
     }];
    
}

//普通手机登录
+(void)loginWithUserName:(NSString *)userName
                password:(NSString*)pwd
                  target:(UIViewController *)targetVC
                  sucess:(void (^)(id value))sucessBlock
                 failure:(void (^)(id value))failureBlock
{
    
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    params[@"username"]=userName;
    
    NSString *randCode=  [self ret32bitString];
    
    params[@"userpwd"]=[self getParamPwdWithPassword:pwd randCode:randCode];
    
   
    params[@"randCode"]=randCode;
    
    [SVProgressHUD show];
    
    [[NetWorkManager sharedInstance] requestDataForPOSTWithURL:URL_For_Login
                                                    parameters:params
                                                    Controller:targetVC
                                                       success:^(id responseObject)
     {
         
         NSString * message=  [responseObject objectForKey:@"message"];
         
         [SVProgressHUD showSuccessWithStatus:message];
         
         NSString *key= [responseObject objectForKey:@"key"];
         
         
         [[NSUserDefaults standardUserDefaults] setObject:key forKey:user_name_key];
         
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         if (sucessBlock)
         {
             sucessBlock(responseObject);
             
         }
         
     } failure:^(NSError *error)
     {
         
         if (failureBlock)
         {
             failureBlock(error);
         }
     }];
}
//重置密码
+(void)resetPwdWithPhone:(NSString *)phone
                randCode:(NSString *)randCode
                 userPwd:(NSString *)userPwd
              userPwd_ok:(NSString *)userPwd_ok
                  target:(UIViewController *)targetVC
                  sucess:(void (^)(id value))sucessBlock
                 failure:(void (^)(id value))failureBlock{

    if (!phone.length||!randCode.length||!userPwd.length||!userPwd_ok.length)
    {
        [SVProgressHUD showErrorWithStatus:@"参数不完整"];
        return;
    }
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"username"]=phone;
    params[@"randCode"]=randCode;
    params[@"userpwd"]=userPwd;
    params[@"userpwd_ok"]=userPwd_ok;
    
    [SVProgressHUD show];
    [[NetWorkManager sharedInstance] requestDataForPOSTWithURL:URL_For_FindPwd
                                                    parameters:params
                                                    Controller:targetVC
                                                       success:^(id responseObject)
     {
         
         [SVProgressHUD showSuccessWithStatus:@"重置成功."];
         
         NSString *key= [responseObject objectForKey:@"key"];
         
         
         [[NSUserDefaults standardUserDefaults] setObject:key forKey:user_name_key];
         
         [[NSUserDefaults standardUserDefaults] synchronize];
         
         if (sucessBlock)
         {
             sucessBlock(responseObject);
             
         }
         
     } failure:^(NSError *error)
     {
         
         if (failureBlock)
         {
             failureBlock(error);
         }
     }];
    
    
}
+(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

+(NSString *)getParamPwdWithPassword:(NSString *)password randCode:(NSString *)randCode
{
    
    NSString * md5Final = [MD5Encryption md5by32:password];
    
    NSString *code=  [NSString stringWithFormat:@"%@%@",md5Final,randCode.lowercaseString];
    
    NSString *userpwd= [MD5Encryption md5by32:code];
    
    
    return userpwd;
}

@end
