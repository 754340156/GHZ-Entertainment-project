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
#import "GHZChatHomeViewController.h"
#import <EMSDK.h>
@interface GHZLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@end

@implementation GHZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//登录按钮

- (IBAction)loginAction:(UIButton *)sender
{
    EMError *error = nil;
    //进来先判断是否是自动登录,如果没有,先登录,如果有就自动登录了
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        [[EMClient sharedClient]asyncLoginWithUsername:self.userNameLabel.text password:self.passwordLabel.text success:^{
            NSLog(@"登录成功");
            //设置自动登录
            [[EMClient sharedClient].options setIsAutoLogin:YES];
            [self.navigationController setViewControllers:@[[[GHZChatHomeViewController alloc]init]] animated:YES];
        } failure:^(EMError *aError) {
             NSLog(@"登录失败 = %@",error.description);
        }];
    }
}
//注册按钮
- (IBAction)registAction:(UIButton *)sender
{
    GHZRegistViewController *registVC = [[GHZRegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

@end
