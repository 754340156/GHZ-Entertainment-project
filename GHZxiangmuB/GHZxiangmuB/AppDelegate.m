//
//  AppDelegate.m
//  xiangmu
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+GHZUMeng.h"
#import "AppDelegate+GHZEaseMobAPNS.h"
#import "CoreLaunchLite.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Umeng
    [self  setUMengWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    //环信
    [self setEaseMobWithApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    



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
