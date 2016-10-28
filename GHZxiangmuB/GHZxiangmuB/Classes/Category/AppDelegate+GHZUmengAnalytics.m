//
//  AppDelegate+GHZUmengAnalytics.m
//  GHZxiangmuB
//
//  Created by    on 16/7/22.
//  Copyright © 2016年  赵哲. All rights reserved.
// 统计

#import "AppDelegate+GHZUmengAnalytics.h"
#import <UMMobClick/MobClick.h>
@implementation AppDelegate (GHZUmengAnalytics)
- (void)setUmengAnalyticsWithApplication:(UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions
{
    //进入后台持久化设置
    [MobClick setBackgroundTaskEnabled:YES];
    UMConfigInstance.appKey = @"578630b167e58e73ff0017a7";
    UMConfigInstance.channelId = @"";
    //UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}
@end
