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
    
}
//登录按钮

- (IBAction)loginAction:(UIButton *)sender
{
    EMError *error = nil;
    [[EMClient sharedClient]asyncLoginWithUsername:self.userNameLabel.text password:self.passwordLabel.text success:^{
        NSLog(@"登录成功");
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            GHZChatHomeViewController *chatHomeVC = [[GHZChatHomeViewController alloc] init];
            chatHomeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatHomeVC animated:YES];
        });
    } failure:^(EMError *aError) {
        NSLog(@"登录失败 = %@",error.description);
    }];
    
}
//注册按钮
- (IBAction)registAction:(UIButton *)sender
{
    GHZRegistViewController *registVC = [[GHZRegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

@end
