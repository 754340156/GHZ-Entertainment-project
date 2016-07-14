//
//  AppDelegate+GHZEaseMobAPNS.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "AppDelegate+GHZEaseMobAPNS.h"
#import "GHZTabBarViewController.h"
#import "GHZLoginViewController.h"
#import "GHZNavViewController.h"
#import <EMSDK.h>
@implementation AppDelegate (GHZEaseMobAPNS)
- (void)setEaseMobWithApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    EMOptions *options = [EMOptions optionsWithAppkey:@"a754340156#ghzxiangmub"];
    options.apnsCertName = @"kaifazhengshu";
    options.enableConsoleLog = NO;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //判断是否是登录状态,如果登录状态就自动登录
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (isAutoLogin) {
        //进入主界面
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor grayColor];
        [self.window makeKeyAndVisible];
        self.window.rootViewController = [[GHZTabBarViewController alloc] init];

        //iOS8 注册APNS
        if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
            [application registerForRemoteNotifications];
            UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
            UIUserNotificationTypeSound |
            UIUserNotificationTypeAlert;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        }
        else{
            UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert;
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil]];
        }
        EMPushOptions *options = [[EMClient sharedClient] getPushOptionsFromServerWithError:nil];
        NSLog(@"%@",options.nickname);
    }else
    {
        //进入登录页面
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        GHZNavViewController *navVC = [[GHZNavViewController alloc] initWithRootViewController:[[GHZLoginViewController alloc]init]];
        [self.window makeKeyAndVisible];
        self.window.rootViewController = navVC;
    }

}
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EMClient sharedClient] asyncBindDeviceToken:deviceToken success:^{
        NSLog(@"发送token成功");
    } failure:^(EMError *aError) {
        NSLog(@"发送token失败,%@",aError.errorDescription);
    }];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"注册token失败%@",error);
}
@end
