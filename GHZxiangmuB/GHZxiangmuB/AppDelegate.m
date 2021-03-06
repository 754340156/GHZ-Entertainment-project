//
//  AppDelegate.m
//  xiangmu
//
//  Created by    on 16/7/6.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+GHZUMeng.h"
#import "AppDelegate+GHZUmengAnalytics.h"
#import "AppDelegate+GHZEaseMobAPNS.h"
#import "AppDelegate+GHZNetWorkStatus.h"
#import "CoreLaunchLite.h"
#import <EMSDK.h>
@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Umeng分享
    [self  setUMengWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    //Umeng统计
    [self setUmengAnalyticsWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    //环信
    [self setEaseMobWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    //监听网络状态
    [self  appNetWorkStatus];
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    //设置启动图
    [CoreLaunchLite animWithWindow:self.window image:nil];
    return YES;
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

@end
