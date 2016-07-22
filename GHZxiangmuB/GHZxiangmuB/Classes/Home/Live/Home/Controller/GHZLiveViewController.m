//
//  GHZLiveViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLiveViewController.h"
#import "GHZCareViewController.h"
#import "GHZHotViewController.h"
#import "GHZLiveNewViewController.h"
#import "GHZViewController.h"
#import "GHZLiveWebViewController.h"
#import "GHZShowingViewController.h"
#import "GHZSelectedView.h"
#import <UMMobClick/MobClick.h>
@interface GHZLiveViewController ()<UIScrollViewDelegate>
@end

@implementation GHZLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScrollView];
    [self setChildViewController];
    [self setTopMenuView];
    [self setNavigationItem];
    [self scrollViewDidEndScrollingAnimation:self.contentView];
   
    self.view.backgroundColor = BackColor;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topMenuView.hidden = NO;
    //统计页面
    [MobClick beginLogPageView:@"直播模块父控制器"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.topMenuView.hidden = YES;
    [MobClick endLogPageView:@"直播模块父控制器"];
}
- (void)setScrollView
{
    self.contentView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.contentView.contentSize = CGSizeMake(GHZScreenWidth * 3, 0);
//    self.contentView.backgroundColor = [UIColor whiteColor];
    // 去掉滚动条
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    // 设置分页
    self.contentView.pagingEnabled = YES;
    // 设置代理
    self.contentView.delegate = self;
    // 去掉弹簧效果
    self.contentView.bounces = NO;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.contentView];
}

- (void)setChildViewController
{
    GHZLiveNewViewController *newVC = [[GHZLiveNewViewController alloc] init];
    [self addChildViewController:newVC];
    
    GHZHotViewController *hotVC = [[GHZHotViewController alloc] init];
    [self addChildViewController:hotVC];
    
    GHZCareViewController *careVC = [[GHZCareViewController alloc] init];
    [self addChildViewController:careVC];
}
// 设置顶部选择器
- (void)setTopMenuView
{
    self.topMenuView = [[GHZSelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.topMenuView.GHZ_x = 45;
    self.topMenuView.GHZ_width = GHZScreenWidth - 45 * 2;
     __weak typeof(self)weakself = self;
    self.topMenuView.selectedBlock = ^(HomeType type)
     {
        [weakself.contentView setContentOffset:CGPointMake(type * GHZScreenWidth, -64)  animated:YES];
     };
    [self.navigationController.navigationBar addSubview:self.topMenuView];
    
}
- (void)setNavigationItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStylePlain target:self action:@selector(rankAction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"living_click_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
}
- (void)rankAction
{
    //事件统计
    [MobClick event:@"直播界面排行榜按钮点击事件"];
    GHZLiveWebViewController *webVC = [[GHZLiveWebViewController alloc] init];
    webVC.webUrl = rankUrl;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)searchAction
{
    //去直播
    GHZShowingViewController *showingVC = [[GHZShowingViewController alloc] init];
    [self presentViewController:showingVC animated:YES completion:^{
    }];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.GHZ_width;
    
    // 取出子控制器
    GHZViewController *vc = self.childViewControllers[index];
    vc.view.GHZ_x = scrollView.contentOffset.x;
    vc.view.GHZ_y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.GHZ_height = scrollView.GHZ_height;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    CGFloat page = scrollView.contentOffset.x / GHZScreenWidth;
    CGFloat offsetX = scrollView.contentOffset.x / GHZScreenWidth * (self.topMenuView.GHZ_width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    self.topMenuView.underLine.GHZ_x = 15 + offsetX;
    if (page == 1 ) {
        self.topMenuView.underLine.GHZ_x = offsetX + 10;
    }else if (page > 1){
        self.topMenuView.underLine.GHZ_x = offsetX + 5;
    }
    self.topMenuView.selectedType = (int)(page + 0.5);
}



@end
