//
//  AppDelegate+GHZUMeng.m
//  GHZxiangmuB
//
//  Created by    on 16/7/14.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "AppDelegate+GHZUMeng.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
@implementation AppDelegate (GHZUMeng)
- (void)setUMengWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"57490f1ee0f55a75d5002f3f"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx91c82e28b6f39be5" appSecret:@"e78a4b9bfc124ca698bb1cceaa7e9506" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105540512" appKey:@"yp43MAUVwshmOSx2" url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"198644486"
                                              secret:@"b247c175bb25018266b4fdc615995d14"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

// Umeng系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

@end
