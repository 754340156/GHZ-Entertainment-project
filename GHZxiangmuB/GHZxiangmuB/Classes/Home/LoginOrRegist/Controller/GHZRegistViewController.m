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
@interface GHZRegistViewController ()<UITextFieldDelegate>
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
    self.userNameLabel.delegate = self;
    self.passwordLabel.delegate = self;
    self.conPasswordLabel.delegate = self;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = self.backView.GHZ_width * 0.5;
}
- (IBAction)registAction:(UIButton *)sender
{
    if ([self.userNameLabel.text isEqualToString:@""]) {
        [GHZMBManager showBriefAlert:@"用户名不能为空"];
        return;
    }
    if ([self.passwordLabel.text isEqualToString:@""]) {
        [GHZMBManager showBriefAlert:@"密码不能为空"];
    }
    if (![self.passwordLabel.text isEqualToString:self.conPasswordLabel.text]) {
        [GHZMBManager showBriefAlert:@"两次密码不一致"];
        return;
    }
    [[EMClient sharedClient] asyncRegisterWithUsername:self.userNameLabel.text password:self.passwordLabel.text success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [GHZMBManager showBriefAlert:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(EMError *aError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (aError.code == 203) {
                 [GHZMBManager showBriefAlert:@"用户名已存在"];
            }else
            {
                 [GHZMBManager showBriefAlert:@"注册失败"];
            }
        });
    }];
}
- (IBAction)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 键盘处理
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userNameLabel resignFirstResponder];
    [self.passwordLabel resignFirstResponder];
    [self.conPasswordLabel resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userNameLabel resignFirstResponder];
    [self.passwordLabel resignFirstResponder];
    [self.conPasswordLabel resignFirstResponder];
    return YES;
}
@end
