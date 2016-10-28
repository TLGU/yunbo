//
//




#pragma mark -  * * * * * * * * * * * * * * 域名切换 * * * * * * * * * * * * * *

#define ENVIRONMENT 0

#if ENVIRONMENT == 0

/**
 *  域名
 *
 *  @param 开发环境
 *
 */
//#define YGBaseURL @"http://121.40.177.251:3330/duohaowan/"//外网
#define YGBaseURL @"http://192.168.1.108:8080/duohaowan/"//内网

#elif ENVIRONMENT ==1

/**
 *  域名
 *
 *  @param 测试环境
 *
 */
#define YGBaseURL @"http://192.168.1.108:8080/duohaowan/"

#elif ENVIRONMENT ==2

/**
 *  域名
 *
 *  @param 正式环境
 *
 */
#define YGBaseURL @"http://121.40.177.251:3330/duohaowan/"


#endif /* HTTPURLDefine_h */

#pragma mark -  * * * * * * * * * * * * * * 首页 URL * * * * * * * * * * * * * *



#pragma mark -  * * * * * * * * * * * * * * User URL * * * * * * * * * * * * * *





//获取用户验证码
#define URL_For_UserRandCode @"rand/getUserPhoneRand.do"
//验证码
#define URL_For_RandCode @"rand/getPhoneRand.do"
//登录
#define URL_For_Login @"front/login_simple.do"
//三方登录
#define URL_For_Third_Login @"front/register_third_user.do"
//注册
#define URL_For_Register @"front/register.do"
//找回密码
#define URL_For_FindPwd  @"front/resetPassword.do"
































