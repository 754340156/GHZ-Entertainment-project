//
//  GHZRegistViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZRegistViewController.h"
#import "GHZMBManager.h"
#import "NarikoTextField.h"
#import <EMSDK.h>
@interface GHZRegistViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NarikoTextField *userNameLabel;
@property (weak, nonatomic) IBOutlet NarikoTextField *passwordLabel;
@property (weak, nonatomic) IBOutlet NarikoTextField *conPasswordLabel;
@end

@implementation GHZRegistViewController
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
    self.conPasswordLabel.placeHolderLabel.text = @"请确认密码";
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = self.backView.GHZ_width * 0.5;
}
- (IBAction)registAction:(UIButton *)sender
{
    [[EMClient sharedClient] asyncRegisterWithUsername:self.userNameLabel.text password:self.passwordLabel.text success:^{
         [GHZMBManager showBriefMessage:@"注册成功" InView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(EMError *aError) {
        [GHZMBManager showBriefMessage:@"注册失败" InView:self.view];
         NSLog(@"注册失败 = %@",aError.errorDescription);
    }];
}
- (IBAction)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userNameLabel resignFirstResponder];
    [self.passwordLabel resignFirstResponder];
    [self.conPasswordLabel resignFirstResponder];
}
@end
