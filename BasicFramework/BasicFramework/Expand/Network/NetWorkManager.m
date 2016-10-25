//
//
#define  KEY_DEVICE_UUID @"KEY_DEVICE_UUID"

#import <MyUUID/SPIMyUUID.h>
#import "MD5Encryption.h"
#import "NetWorkManager.h"
#define kTimeoutInterval  15


/**
 *  取
 */
#define kCookieID_KEY @"Cookie_key"

@interface NetWorkManager ()<UIAlertViewDelegate>

@property(nonatomic,strong)UIAlertView *myAlert;

@end


@implementation NetWorkManager
static NetWorkManager *network = nil;
+ (instancetype)sharedInstance;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[super allocWithZone:NULL] init];
        
    });
    return network;
}
-(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[SPIMyUUID load:KEY_DEVICE_UUID];
    
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        [SPIMyUUID save:KEY_DEVICE_UUID data:strUUID];
        
    }
    return strUUID;
    
    
}
- (void)SynchronizationForRequestType:(NSString *)RequestType WithURL:(NSString *)URL parameters:(NSString *)parametersStr Controller:(UIViewController *)Controller success:(void(^)(id response,id data))success
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",YGBaseURL,URL]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:RequestType];
    
    [request setValue:[USER_ID stringValue] forHTTPHeaderField:@"uid"];
    [request setValue:kVersion forHTTPHeaderField:@"version"];
    [request setValue:[self getUUID] forHTTPHeaderField:@"EquipmentOnlyLabeled"];
//    NSArray *temp_array = [NAMEANDPWFORBASIC componentsSeparatedByString:@"#"];
//    NSData *basicAuthCredentials = [[NSString stringWithFormat:@"%@:%@", temp_array[0], temp_array[1]] dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *base64AuthCredentials = [basicAuthCredentials base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
//    [request setValue:[NSString stringWithFormat:@"Basic %@", base64AuthCredentials] forHTTPHeaderField:@"Authorization"];
    
    if (parametersStr) {
        
        NSData *data = [parametersStr dataUsingEncoding:NSUTF8StringEncoding];
        
        [request setHTTPBody:data];
    }
    
    dispatch_semaphore_t disp = dispatch_semaphore_create(0);
    
    
    NSURLSessionDataTask *dataTask =  [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        
        success (response,data);
        
        
        
        dispatch_semaphore_signal(disp);
    }];
    
    
    [dataTask resume];
    dispatch_semaphore_wait(disp, DISPATCH_TIME_FOREVER);
}






-(void)UploadPicturesToServerPic:(UIImage *)image url:(NSString *)url uiserid:(NSString *)userid success:(void (^)(id responseObject))success failure:(void (^)(NSError *  error))failure
{
    NSString *str = [NSString stringWithFormat:@"%@%@?version=%@&userId=%@",YGBaseURL,url,kVersion,userid];
    
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    
    [manager POST:str parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSDate *now = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy_MM_dd_hh_mm_ss_"];
        NSString *picname = [formatter stringFromDate:now];
        
        NSString *path = NSTemporaryDirectory();
        NSString *file = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%d(SPI-Piles)_%@.png",arc4random()%1000,picname]];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.06);
        
        [formData appendPartWithFileData:imageData name:@"profile" fileName:file mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success (responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            failure(error);
        }
        
    }];
    
}

-(void)requestDataForPOSTWithURL:(NSString *)URL parameters:(id)parameters Controller:(UIViewController *)Controller success:(void(^)(id responseObject))success failure:(void (^)(NSError *  error))failure
{
     [self requestWithMethod:RequestMethodPost Url:URL parameters:parameters Controller:Controller success:success failure:failure];
    
}
-(void)requestDataForGETWithURL:(NSString *)URL parameters:(id)parameters Controller:(UIViewController *)Controller success:(void(^)(id responseObject))success failure:(void (^)(NSError *  error))failure
{
    
    [self requestWithMethod:RequestMethodGet Url:URL parameters:parameters Controller:Controller success:success failure:failure];
}
//不需要登录的接口
-(BOOL)isNotLoginUrl:(NSString *)urlStr{
    if ([urlStr isEqualToString:URL_For_RandCode]) {
        return YES;
    }
    if ([urlStr isEqualToString:URL_For_Login]) {
        return YES;
    }
    if ([urlStr isEqualToString:URL_For_Third_Login]) {
        return YES;
    }
    if ([urlStr isEqualToString:URL_For_Register]) {
        return YES;
    }
    if ([urlStr isEqualToString:URL_For_FindPwd]) {
        return YES;
    }
    if ([urlStr isEqualToString:URL_For_UserRandCode]) {
        return YES;
    }
    return NO;
}

-(void)requestWithMethod:(RequestMethod)method Url:(NSString*)URL parameters:(id)parameters Controller:(UIViewController *)Controller success:(void(^)(id responseObject))success failure:(void (^)(NSError *  error))failure
{
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
   
    if (![self isNotLoginUrl:URL]) {
        parameters=  [self constructParams:parameters];
    }
   
    
    URL = [NSString stringWithFormat:@"%@%@",YGBaseURL,URL];
    
    
    if (method==RequestMethodGet)
    {
        [manager GET:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSInteger statusCode= [[responseObject objectForKey:@"statusCode"] integerValue];
             NSString   * message= [responseObject objectForKey:@"message"];
             if (statusCode!=NetworkResponseStatusSuccess) {
                 [SVProgressHUD showErrorWithStatus:message?message:@"未知错误!"];
                 if (failure) {
                     NSError *err=[NSError errorWithDomain:message code:statusCode userInfo:nil];
                     failure(err);
                 }
             }else{
                 if (success) {
                     success(responseObject);
                 }
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
             NSError *err=[NSError errorWithDomain:@"网络连接异常" code:13527 userInfo:nil];
             failure(err);
             
         }];
    }
    else
    {
        [manager POST:URL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             NSInteger statusCode= [[responseObject objectForKey:@"statusCode"] integerValue];
             NSString   * message= [responseObject objectForKey:@"message"] ;
             if (statusCode!=NetworkResponseStatusSuccess) {
                 [SVProgressHUD showErrorWithStatus:message?message:@"未知错误!"];
                 if (failure) {
                     NSError *err=[NSError errorWithDomain:message code:statusCode userInfo:nil];
                     failure(err);
                 }
             }else{
                 if (success) {
                     success(responseObject);
                 }
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
             NSError *err=[NSError errorWithDomain:@"网络连接异常" code:13527 userInfo:nil];
             failure(err);
             
         }];
    }
    
    
    
}


- (AFHTTPSessionManager *)HTTPSessionManager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /**
     *  先删除cookies
     */
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    
//    NSArray *cookies = [NSArray arrayWithArray:[cookieJar cookies]];
//    
//    for (NSHTTPCookie *cookie in cookies) {
//        [cookieJar deleteCookie:cookie];
//    }
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;//默认 NSUTF8StringEncoding
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    
    [manager.responseSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setTimeoutInterval:kTimeoutInterval];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", @"image/*"]];
    
   /*
    manager.securityPolicy=[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[USER_ID stringValue] forHTTPHeaderField:@"uid"];
    [manager.requestSerializer setValue:[self getUUID] forHTTPHeaderField:@"EquipmentOnlyLabeled"];
    [manager.requestSerializer setValue:kVersion forHTTPHeaderField:@"version"];
    manager.operationQueue.maxConcurrentOperationCount = 2;
     
    */
    
    
    return manager;
}
/**
 *  配置请求头
 *
 *  @return NSString
 */
//-(NSString *)getRequestHeaderParameter
//{
//    return [NSString stringWithFormat:@"uid=%@;version=%@",USER_ID,kVersion];
//}

- (void)updateFile:(NSArray*)fileData url:(NSString*)url parameters:(NSMutableDictionary*)params fileName:(NSString*)fileName viewControler:(UIViewController*)vc success:(void(^)(id result))result failure:(void(^)(NSError *  error))failure;
{
    url = [NSString stringWithFormat:@"%@%@",@"http://10.0.136.41:8080/iceland-ws/",url];
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int index = 0;
        for(UIImage *image in fileData)
        {
            NSString* tempFileName = [NSString stringWithFormat:@"%@%d.png",fileName,index];
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            [formData appendPartWithFileData:imageData name:@"file" fileName:tempFileName mimeType:@"image/png"];
            index ++;
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        result(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - alertview
static UIViewController *tempVC = nil;
-(void)alertShowWith:(UIViewController *)VC
{
    tempVC = VC;
    [self.myAlert show];
}
-(UIAlertView *)myAlert
{
    if (!_myAlert) {
        
        _myAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的帐号已在另一台设备登录，请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    }
    return _myAlert;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (tempVC) {
        
        tempVC = nil;
        
        [self clearUserCaches];
        [tempVC dismissViewControllerAnimated:YES completion:nil];
    }
}
/**
 *   解析Cookie获取kTokenID
 */
-(NSString *)getUserTokenIdInCookie:(NSString *)theCookie
{
    NSString *basic_str = @"";

    
    NSArray *theArray = [theCookie componentsSeparatedByString:@"; "];
    
    for (int i =0 ; i<[theArray count]; i++) {
        
        NSString *val=theArray[i];
        if ([val rangeOfString:@"JSESSIONID="].length>0)
        {
            basic_str = val;
        }
    }
    
   
    
    
    return basic_str;
}
-(void)clearUserCaches
{
    [APPSINGLE DeleteValueInMyLocalStoreForKey:KEY_USER_ID];
    [APPSINGLE DeleteValueInMyLocalStoreForKey:kReachability];
}

//构建传递参数

-(NSDictionary *)constructParams:(NSMutableDictionary*)sender
{
     NSString *name= [[NSUserDefaults standardUserDefaults] objectForKey:user_name_key];
    if (!name||!name.length) {
        return sender;
    }
    
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    NSString *usernme= [[NSUserDefaults standardUserDefaults] objectForKey:user_name_key];
    if (!usernme) {
        usernme=@"";
        
    }
    dict[@"name"]=usernme;
    dict[@"randCode"]=[self ret32bitString];
    dict[@"encrpt"]=@"enAes";
    dict[@"isEncryption"]=@"false";
    dict[@"mode"]=@"2";
    
    NSString *paramters=  [self dictionaryToJson:sender];
    dict[@"data"]=paramters;
    
    NSString *key= [[NSUserDefaults standardUserDefaults] objectForKey:user_key_key];
    
    NSString *text= [key stringByAppendingString:dict[@"randCode"]];
   
    
    
    
    
    if (!name||!name.length) {
        name=@"";
    }
    
    NSString *tempKey=[MD5Encryption  md5by32:text];
    NSString *mac=  [[tempKey stringByAppendingString:name] stringByAppendingString:paramters];
    dict[@"mac"]=[MD5Encryption  md5by32:mac];
    
    
    
    return dict;
    
}
-(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
@end
