//
//  GHZNavViewController.m
//  xiangmu
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNavViewController.h"

@interface GHZNavViewController ()

@end

@implementation GHZNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationBar.barTintColor = NavBarColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        //如果push进来的不是第一个控制器
        UIButton *coustomButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [coustomButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        //根据邻面的控件尺寸决定bounds
        coustomButton.frame = CGRectMake(0, 0, 20, 25);
        //设置内边距可以设置按钮向左靠
        coustomButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [coustomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [coustomButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [coustomButton addTarget:self action:@selector(coustomButton) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:coustomButton];
    }
    [super pushViewController:viewController animated:animated];
}


- (void)coustomButton
{
    [self popViewControllerAnimated:YES];
}


@end
