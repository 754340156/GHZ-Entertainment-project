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
#import "GHZSelectedView.h"
@interface GHZLiveViewController ()<UIScrollViewDelegate>
/**  ScrollView */
@property (nonatomic,strong)UIScrollView *contentView;
/**  顶部选择器 */
@property (nonatomic,strong) GHZSelectedView *topMenuView;
@end

@implementation GHZLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScrollView];
    [self setChildViewController];
    [self setTopMenuView];
    [self scrollViewDidEndScrollingAnimation:self.contentView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topMenuView.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.topMenuView.hidden = YES;
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
        [weakself.contentView setContentOffset:CGPointMake(type * GHZScreenWidth, 0)  animated:YES];
     };
    [self.navigationController.navigationBar addSubview:self.topMenuView];
    
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
    vc.view.GHZ_height = scrollView.GHZ_height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
//    CGFloat bottom = self.tabBarController.tabBar.GHZ_height;
//    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//    vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottom, 0);
    // 设置滚动条的内边距
//    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
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
