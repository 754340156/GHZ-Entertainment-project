//
//  AppDelegate.m
//  xiangmu
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "AppDelegate.h"
#import "GHZLeftViewController.h"
#import "CoreLaunchLite.h"
#import "GHZTabBarViewController.h"
#import "EaseUI.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //环信
    EMOptions *options = [EMOptions optionsWithAppkey:@"a754340156#ghzxiangmub"];
    options.apnsCertName = nil;
    options.enableConsoleLog = NO;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //抽屉效果
    GHZLeftViewController * leftDrawer = [[GHZLeftViewController alloc] init];
    GHZTabBarViewController *tabVC = [[GHZTabBarViewController alloc] init];
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabVC leftDrawerViewController:leftDrawer rightDrawerViewController:nil];
    
    self.drawerController.maximumLeftDrawerWidth = 280;
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    self.drawerController.centerHiddenInteractionMode = MMDrawerOpenCenterInteractionModeFull;
    [self.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState swingingDoorVisualStateBlock]];
    
//    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//        if (drawerSide == MMDrawerSideLeft) {
//             drawerController.leftDrawerViewController.view .alpha = percentVisible;
//        }
//    }];
    self.window.rootViewController = self.drawerController;
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
