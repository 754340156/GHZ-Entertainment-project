//
//  GHZTabBarViewController.m
//  xiangmu
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTabBarViewController.h"
#import "GHZNavViewController.h"
#import "GHZCreamViewController.h"
#import "GHZNewViewController.h"
#import "GHZLiveViewController.h"
#import "GHZProfileViewController.h"
#import "GHZLoginViewController.h"
#import "EMSDK.h"
@interface GHZTabBarViewController ()<EMClientDelegate>

@end

@implementation GHZTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarWithViewController:[[GHZCreamViewController alloc]init] image:@"paper" selectImage:@"paperH" title:@"精华"];
    
    [self setTabBarWithViewController:[[GHZNewViewController alloc]init] image:@"video" selectImage:@"videoH" title:@"最新"];
    
    [self setTabBarWithViewController:[[GHZLiveViewController alloc]init] image:@"2image" selectImage:@"2imageH" title:@"直播"];
    //自定登录判定
    [self setTabBarWithViewController:[self setIsAutoLoginWithChatHomeVC:[[GHZProfileViewController alloc]init] loginVC:[[GHZLoginViewController alloc]init]] image:@"person" selectImage:@"personH" title:@"聊天"];
    [[EMClient sharedClient]addDelegate:self delegateQueue:nil];
}


/**
 *  创建导航控制器的方法
 */
- (void)setTabBarWithViewController:(UIViewController *)viewControler image:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title
{
    GHZNavViewController *navc = [[GHZNavViewController alloc] initWithRootViewController:viewControler];
    navc.tabBarItem.title = title;
    [navc.tabBarItem setImage:[UIImage imageNamed:image]];
    [navc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:navc];
}
 //自定登录判定方法
- (UIViewController *)setIsAutoLoginWithChatHomeVC:(GHZProfileViewController *)profileVC loginVC:(GHZLoginViewController *)loginVC
{
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (isAutoLogin) {
        return profileVC;
    }
    return loginVC;
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
