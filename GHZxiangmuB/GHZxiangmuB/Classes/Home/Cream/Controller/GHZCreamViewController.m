//
//  GHZRootViewController.m
//  xiangmu
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCreamViewController.h"
#import "GHZCrunchiesViewController.h"

@interface GHZCreamViewController ()
@end

@implementation GHZCreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GHZRGBColor(223, 223, 223);
    //设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
    //self.hidesBottomBarWhenPushed = YES;
}

- (void)tagClick{
    GHZCrunchiesViewController *CrunchiesVC = [GHZCrunchiesViewController new];
    [self.navigationController pushViewController:CrunchiesVC animated:YES];

    GHZLogFunc;


}




@end
