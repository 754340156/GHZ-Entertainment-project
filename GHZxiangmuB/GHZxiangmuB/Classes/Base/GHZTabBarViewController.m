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
#import "PJXBounceAnimation.h"
#import "PJXAnimatedTabBarItem.h"
@interface GHZTabBarViewController ()<EMClientDelegate>

@end

@implementation GHZTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarWithViewController:[[GHZCreamViewController alloc]init] image:@"tabBar_essence_click_icon" selectImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    [self setTabBarWithViewController:[[GHZNewViewController alloc]init] image:@"tabBar_new_click_icon" selectImage:@"tabBar_new_click_icon" title:@"最新"];
    
    [self setTabBarWithViewController:[[GHZLiveViewController alloc]init] image:@"tabBar_live_click_icon" selectImage:@"tabBar_live_click_icon" title:@"直播"];
    //自定登录判定
    [self setTabBarWithViewController:[[GHZProfileViewController alloc]init] image:@"tabBar_profile_click_icon" selectImage:@"tabBar_profile_click_icon" title:@"个人中心"];
}
/**
 *  创建导航控制器的方法
 */
- (void)setTabBarWithViewController:(UIViewController *)viewControler image:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title
{
    GHZNavViewController *navc = [[GHZNavViewController alloc] initWithRootViewController:viewControler];
    navc.tabBarItem.title = title;
      self.tabBar.tintColor = NavBarColor;
    [navc.tabBarItem setImage:[UIImage imageNamed:image]];
    [navc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
  
   
    
    
    
    
    
    
//    PJXBounceAnimation *bounceAnimation = [[PJXBounceAnimation alloc] init];
//    bounceAnimation.textSelectedColor = NavBarColor;
//    bounceAnimation.iconSelectedColor = NavBarColor;
//    
//    PJXAnimatedTabBarItem *tabBarItem = [[PJXAnimatedTabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:nil];
//    tabBarItem.animation = bounceAnimation;
//    tabBarItem.textColor = NavBarColor;
//    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
//    UILabel *label = [[UILabel alloc] init];
//    label.text = title;
//    tabBarItem.iconView = [[PJXIconView alloc] initWithIcon:iconView textLabel:label];
//    navc.tabBarItem = tabBarItem;
     [self addChildViewController:navc];
}


@end
