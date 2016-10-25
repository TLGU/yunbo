//
//  AccountService.h
//  BasicFramework
//
//  Created by mr_right on 16/10/20.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>
//用户管理模块服务类
@interface AccountService : NSObject

//获取手机验证码
+(void)getPhoneRanCodeWithPhone:(NSString *)phone
                         isUser:(BOOL)bo
                         target:(UIViewController *)targetVC
                         sucess:(void (^)(id value))sucessBlock
                        failure:(void (^)(id value))failureBlock;
//手机注册
+(void)registerWithPhone:(NSString *)phone
                randCode:(NSString *)randCode
                 userPwd:(NSString *)userPwd
              userPwd_ok:(NSString *)userPwd_ok
                  target:(UIViewController *)targetVC
                  sucess:(void (^)(id value))sucessBlock
                 failure:(void (^)(id value))failureBlock;
//三方平台登录
//第三方用户类型
//微信   1
//QQ    2
//微博   3
+(void)thirdLoginWithNickname:(NSString *)nickname
              headimgurl:(NSString *)headimgurl
                     sex:(NSString *)sex
           third_user_id:(NSString *)third_user_id
         third_user_type:(NSString *)third_user_type
                  target:(UIViewController *)targetVC
                  sucess:(void (^)(id value))sucessBlock
                 failure:(void (^)(id value))failureBlock;




+(void)loginWithUserName:(NSString *)userName
                password:(NSString*)pwd
                  target:(UIViewController *)targetVC
                  sucess:(void (^)(id value))sucessBlock
                 failure:(void (^)(id value))failureBlock;


//重置密码
+(void)resetPwdWithPhone:(NSString *)phone
                randCode:(NSString *)randCode
                 userPwd:(NSString *)userPwd
              userPwd_ok:(NSString *)userPwd_ok
                  target:(UIViewController *)targetVC
                  sucess:(void (^)(id value))sucessBlock
                 failure:(void (^)(id value))failureBlock;
@end
