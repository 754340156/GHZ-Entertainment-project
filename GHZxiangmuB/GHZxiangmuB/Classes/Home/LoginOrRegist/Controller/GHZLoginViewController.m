//
//  GHZLoginViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLoginViewController.h"
#import "GHZRegistViewController.h"
#import "GHZNavViewController.h"
#import "GHZTabBarViewController.h"
#import "GHZChatHomeViewController.h"
#import "GHZUserSetting.h"
#import "UMSocial.h"
#import "NarikoTextField.h"
#import <EMSDK.h>
@interface GHZLoginViewController ()
@property (weak, nonatomic) IBOutlet NarikoTextField *userNameLabel;
@property (weak, nonatomic) IBOutlet NarikoTextField *passwordLabel;

@end

@implementation GHZLoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameLabel.placeHolderLabel.text = @"请输入用户名";
    self.passwordLabel.placeHolderLabel.text = @"请输入密码";
    
}
//登录按钮

- (IBAction)loginAction:(UIButton *)sender
{
    [GHZMBManager showLoading];
    [[EMClient sharedClient] asyncLoginWithUsername:self.userNameLabel.text password:self.passwordLabel.text success:^{
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [GHZMBManager hideAlert];
             [GHZMBManager showBriefMessage:@"登录成功" InView:self.view];
            [[GHZUserSetting shareInstance] setUserName:self.userNameLabel.text];
            [[GHZUserSetting shareInstance] setNickName:self.userNameLabel.text];
            //跳到主界面
            self.view.window.backgroundColor = [UIColor grayColor];
            self.view.window.rootViewController = [[GHZTabBarViewController alloc] init];
            [self.view.window makeKeyAndVisible];
        });
    } failure:^(EMError *aError) {
        [GHZMBManager hideAlert];
         [GHZMBManager showBriefMessage:@"登录失败" InView:self.view];
        NSLog(@"登录失败 = %@",aError.errorDescription);
    }];
    
}
- (IBAction)registAction:(UIButton *)sender
{
    GHZRegistViewController *registVC = [[GHZRegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

//注册账号密码方法
- (void)setWithUserName:(NSString *)userName password:(NSString *)password nickName:(NSString *)nickName
{
    [GHZMBManager showLoading];
    [[EMClient sharedClient] asyncRegisterWithUsername:userName password:password success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
           [[EMClient sharedClient] asyncLoginWithUsername:userName password:password success:^{
                       [[EMClient sharedClient].options setIsAutoLogin:YES];
               dispatch_async(dispatch_get_main_queue(), ^{
                   [GHZMBManager hideAlert];
                   [GHZMBManager showBriefMessage:@"登录成功" InView:self.view];
                   [[GHZUserSetting shareInstance] setUserName:userName];
                   [[GHZUserSetting shareInstance] setNickName:nickName];
                   //跳到主界面
                   self.view.window.backgroundColor = [UIColor grayColor];
                   self.view.window.rootViewController = [[GHZTabBarViewController alloc] init];
                   [self.view.window makeKeyAndVisible];
               });
           } failure:^(EMError *aError) {
               [GHZMBManager hideAlert];
               [GHZMBManager showBriefMessage:@"登录失败" InView:self.view];
                NSLog(@"登录失败%u",aError.code);
           }];
        });
    } failure:^(EMError *aError) {
        //用户名存在,直接登录
        if (aError.code == 203) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[EMClient sharedClient] asyncLoginWithUsername:userName password:password success:^{
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [GHZMBManager hideAlert];
                         [GHZMBManager showBriefMessage:@"登录成功" InView:self.view];
                        [[GHZUserSetting shareInstance] setUserName:userName];
                        [[GHZUserSetting shareInstance] setNickName:nickName];
                        //跳到主界面
                        self.view.window.backgroundColor = [UIColor grayColor];
                        self.view.window.rootViewController = [[GHZTabBarViewController alloc] init];
                        [self.view.window makeKeyAndVisible];
                    });
                } failure:^(EMError *aError) {
                    [GHZMBManager hideAlert];
                    [GHZMBManager showBriefMessage:@"登录失败" InView:self.view];
                    NSLog(@"登录失败%u",aError.code);
                }];
            });
        }
    }];
}
#pragma mark 第三方登录
- (IBAction)weiboLoginAction:(UIButton *)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
             [self setWithUserName:snsAccount.usid password:snsAccount.accessToken nickName:snsAccount.userName];
        }});
}
- (IBAction)weixinLoginAction:(UIButton *)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
              [self setWithUserName:snsAccount.usid password:snsAccount.accessToken nickName:snsAccount.userName];
        }
        
    });
}
- (IBAction)QQLgoinAction:(UIButton *)sender
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
             [self setWithUserName:snsAccount.usid password:snsAccount.accessToken nickName:snsAccount.userName];
            
        }});
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userNameLabel resignFirstResponder];
    [self.passwordLabel resignFirstResponder];
}
@end
