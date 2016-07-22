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
#import "GHZTabBarViewController.h"
#import "GHZNavViewController.h"
#import "GHZChatHomeViewController.h"
#import "GHZUserSetting.h"
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
        [[GHZUserSetting shareInstance] setNickName:[EMClient sharedClient].currentUsername];
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [[EMClient sharedClient] asyncGetPushOptionsFromServer:^(EMPushOptions *pushOptions) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[EMClient sharedClient] asyncSetApnsNickname:[GHZUserSetting shareInstance].nickName success:^{
                        NSLog(@"设置推送昵称成功");
                    } failure:^(EMError *aError) {
                        NSLog(@"设置推送昵称失败%@",aError.errorDescription);
                    }];
                    NSLog(@"获取推送属性成功%@%u%u",pushOptions.nickname,pushOptions.displayStyle,pushOptions.noDisturbStatus);
                });
                
            } failure:^(EMError *aError) {
                
            }];
        });
    } failure:^(EMError *aError) {
        NSLog(@"发送token失败,%@",aError.errorDescription);
    }];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"注册token失败%@",error);
}

//点击推送处理
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:userInfo[@"aps"][@"alert"][@"body"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即查看", nil];
        [alertView show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
        GHZChatHomeViewController *chatHomeVC = [[GHZChatHomeViewController alloc] init];
                    chatHomeVC.hidesBottomBarWhenPushed = YES;
        GHZTabBarViewController *tab = (GHZTabBarViewController *)self.window.rootViewController;
        [(GHZNavViewController *)tab.viewControllers[0] pushViewController:chatHomeVC animated:YES];
    }
}
#pragma mark -  EMClientDelegate
//自动登录是否成功
- (void)didAutoLoginWithError:(EMError *)aError
{
    if (!aError) {
        NSLog(@"自动登录成功");

    }else
    {
        NSLog(@"自动登录失败%@",aError.errorDescription);
    }
}
//1.监听网络状态
- (void)didConnectionStateChanged:(EMConnectionState)connectionState{
    //EMConnectionConnected = 0,  /*! *\~chinese 已连接
    //EMConnectionDisconnected,   /*! *\~chinese 未连接
    if (connectionState == EMConnectionDisconnected) {
        NSLog(@"网络断开，未连接...");
    }else{
        NSLog(@"网络通了...");
        
    }
}
-(void)willAutoReconnect{
    NSLog(@"将自动重连接...");
    
}
-(void)didAutoReconnectFinishedWithError:(NSError *)error{
    if (!error) {
        NSLog(@"自动重连接成功...");
        
    }else{
        NSLog(@"自动重连接失败... %@",error);
    }
}

@end
