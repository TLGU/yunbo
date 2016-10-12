//
//  AppDelegate.m
//  BasicFramework
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//
//pod install --verbose --no-repo-update
//pod update --verbose --no-repo-update
#import "AppDelegate.h"
#import "RootViewController.h"
#import "BasicMainNC.h"
#import "LoginViewController.h"
#import "BasicMainTBC.h"
#import <UMSocialCore/UMSocialCore.h>
#import "WXApi.h"
#import "WXApiManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)backBlockWithUrl:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    NSLog(@"%@",url.absoluteString);
    
    
    if (!result) {
        // 其他如支付宝支付等SDK的回调
        //        [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    else
    {
        [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    
    return result;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
     return   [self backBlockWithUrl:url];
    
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
  return   [self backBlockWithUrl:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return   [self backBlockWithUrl:url];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
#pragma mark 网络监控打开 当前网络状态，取 kNetworkType 值。
    [[AppSingle Shared]  setReachability];
    
    [self configUmeng];
    
    [self setMyWindowAndRootViewController];
    
    [self.window makeKeyAndVisible];
    
    
    
    
    
    return YES;
}
-(void)setMyWindowAndRootViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];

    
    BasicMainTBC *tbc=[BasicMainTBC new];
    
    self.window.rootViewController =tbc;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

-(void)configUmeng{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57b432afe0f55a9832001a0a"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WEIXIN_APPID appSecret:WEIXIN_APPKEY redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPID  appSecret:QQ_APPKEY redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
   
    
    // 如果不想显示平台下的某些类型，可用以下接口设置
        [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    
}



@end
