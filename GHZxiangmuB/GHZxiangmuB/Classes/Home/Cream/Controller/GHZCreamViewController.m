//
//  GHZRootViewController.m
//  xiangmu
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCreamViewController.h"
#import "GHZCrunchiesViewController.h"
#import "UIBarButtonItem+GHZExtention.h"
#import "GHZAllViewController.h"
#import "GHZVideoViewController.h"
#import "GHZVoiceViewController.h"
#import "GHZPictureViewController.h"
#import "GHZWordViewController.h"


@interface GHZCreamViewController ()<UIScrollViewDelegate>
/**标签栏底部的红色指示器*/
@property (nonatomic, weak) UIView *indicatorView;
/**当前选中的按钮*/
@property (nonatomic, weak) UIButton *selectedButton;
/**顶部的标签*/
@property (nonatomic, weak) UIView *titlesView;

/**底部的所有内容*/
@property (nonatomic, weak) UIScrollView *contentView;


@end

@implementation GHZCreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GHZRGBColor(223, 223, 223);
    //设置导航栏
    [self setupNav];
    
    //初始化所有的子控制器
    [self setupChildsVc];
    
    //设置顶部的标签栏
    [self setupTitleView];
    
    //底部的 scrollView
    [self setupContentView];

}

/**
 *  初始化子控制器
 */
- (void)setupChildsVc{

    GHZAllViewController *all = [GHZAllViewController new];
    [self addChildViewController:all];
    
    GHZVideoViewController *video = [GHZVideoViewController new];
    [self addChildViewController:video];
    
    GHZVoiceViewController *voice = [GHZVoiceViewController new];
    [self addChildViewController:voice];
    
    GHZPictureViewController *picture = [GHZPictureViewController new];
    [self addChildViewController:picture];
    
    GHZWordViewController *word = [GHZWordViewController new];
    [self addChildViewController:word];
}


/**
 *  设置顶部的标签栏
 */
- (void)setupTitleView{
    
    //标题栏整体
    UIView *titleView = [[UIView alloc] init];
//    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
//    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.GHZ_width = self.view.GHZ_width;
    titleView.GHZ_height = 35;
    titleView.GHZ_y = 64;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.GHZ_height = 2;
    indicatorView.tag = -1;
    indicatorView.GHZ_y = titleView.GHZ_height - indicatorView.GHZ_height;
    
    self.indicatorView = indicatorView;
    
    
    //内部的子标签
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    
    NSInteger count = 5;
    CGFloat width = titleView.GHZ_width / count;
    CGFloat height = titleView.GHZ_height;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.GHZ_height = height;
        button.GHZ_width = width;
        button.GHZ_x = i *  width;
        [button setTitle:titles[i] forState:(UIControlStateNormal)];
        //[button layoutIfNeeded]; //强制布局(强制更新子控件的 frame)
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleView addSubview:button];
        
        
        //默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            //让按钮内部的 label 根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.GHZ_width = button.titleLabel.GHZ_width;
//            self.indicatorView.GHZ_width =[titles[i] sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;
            self.indicatorView.GHZ_centerX = button.GHZ_centerX;
        }
    
    }
    
    [titleView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button{
    //修改我们按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.GHZ_centerX = button.GHZ_centerX;
        self.indicatorView.GHZ_width = button.titleLabel.GHZ_width;
    }];
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.GHZ_width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  底部的 scrollView
 */
- (void)setupContentView{

    //不要自动调整 inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [UIScrollView new];
//    contentView.backgroundColor = [UIColor blueColor];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    //设置内边距
//    CGFloat bottom = self.tabBarController.tabBar.GHZ_height;
//    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.GHZ_width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的 view
    [self scrollViewDidEndScrollingAnimation:contentView];
}


/**
 *  设置导航栏
 */
- (void)setupNav{

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

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//添加自控制的 view
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.GHZ_width;

    //取出控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.GHZ_x = scrollView.contentOffset.x;
    
    
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.GHZ_height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    [scrollView addSubview:vc.view];
 }

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{


    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.GHZ_width;
    [self titleClick:self.titlesView.subviews[index]];

}






@end
