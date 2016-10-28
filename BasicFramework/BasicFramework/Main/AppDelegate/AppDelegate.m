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
#import <AlipaySDK/AlipaySDK.h>
#import "SRNewFeaturesViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)backBlockWithUrl:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    NSLog(@"%@",url.absoluteString);
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
        }];
    }

    
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
    
    
    
    BOOL shouldShow = [SRNewFeaturesViewController sr_shouldShowNewFeature];
//    shouldShow = YES; // Set YES for test
    if (shouldShow) {
        NSArray *imageNames = @[@"newfeature1.jpg", @"newfeature2.jpg", @"newfeature4.jpg"];
        SRNewFeaturesViewController *newFeaturesVC = [SRNewFeaturesViewController sr_newFeatureWithImageNames:imageNames
                                                                                           rootViewController:tbc];
        newFeaturesVC.hideSkipButton = NO; // show skip Button
        self.window.rootViewController = newFeaturesVC;
    } else {
        self.window.rootViewController = tbc;
    }
    
    
    
    
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
