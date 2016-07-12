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
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *conPasswordLabel;

@end

@implementation GHZRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
