//
//  GHZRegistViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZRegistViewController.h"
#import <EMSDK.h>
@interface GHZRegistViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *conPasswordLabel;
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
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = self.backView.GHZ_width * 0.5;
    
}
- (IBAction)registAction:(UIButton *)sender
{
    [[EMClient sharedClient] asyncRegisterWithUsername:self.userNameLabel.text password:self.passwordLabel.text success:^{
        NSLog(@"注册成功");
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(EMError *aError) {
         NSLog(@"注册失败 = %@",aError.errorDescription);
    }];
}
- (IBAction)backAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
