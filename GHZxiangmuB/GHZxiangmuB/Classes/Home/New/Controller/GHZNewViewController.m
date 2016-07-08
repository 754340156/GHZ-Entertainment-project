//
//  GHZNewViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewViewController.h"
#import "GHZNewAllViewController.h"
#import "GHZNewMusicViewController.h"
#import "GHZNewPictureViewController.h"
#import "GHZNewVideoViewController.h"
#import "GHZNewWordViewController.h"
@interface GHZNewViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *viewArr;
@property (nonatomic,weak)UIView *titleV;
@property (nonatomic,weak)UIView *redView;
@property (nonatomic,weak)UIButton *selectBtn;
@property (nonatomic,weak)UIScrollView *contentView;
@property (nonatomic,assign)BOOL isS;
@end

@implementation GHZNewViewController



- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
    self.view.backgroundColor = [UIColor blueColor];
    
=======
    [self setuptheNav];
    [self setupChildVC];//子控制器
    [self titleViewNA];//标签栏
    [self setupControlScroll];//scrollview

}

/**
 * 初始化子控制器
 */
-(void)setupChildVC{
    GHZNewAllViewController *all = [[GHZNewAllViewController alloc] init];
    [self addChildViewController:all];
    GHZNewWordViewController *word = [[GHZNewWordViewController alloc] init];
    [self addChildViewController:word];
    GHZNewMusicViewController *music = [[GHZNewMusicViewController alloc] init];
    [self addChildViewController:music];
    GHZNewPictureViewController *picture = [[GHZNewPictureViewController alloc] init];
    [self addChildViewController:picture];
    GHZNewVideoViewController *video = [[GHZNewVideoViewController alloc] init];
    [self addChildViewController:video];
}
-(void)titleViewNA{
    UIView *titleV = [[UIView alloc] init];
    titleV.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titleV.GHZ_width = self.view.GHZ_width;
    titleV.GHZ_height = 35;
    titleV.GHZ_y = 64;
    [self.view addSubview:titleV];
    self.titleV = titleV;
    
    //下面的红线
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.GHZ_height = 2;
    redView.tag = -1;
    redView.GHZ_y = self.titleV.GHZ_height - redView.GHZ_height;
    
    self.redView = redView;
    
    self.viewArr = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    for (NSInteger i = 0; i < self.viewArr.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.GHZ_width = titleV.GHZ_width/self.viewArr.count;
        button.GHZ_height = titleV.GHZ_height;
        button.GHZ_x = i * titleV.GHZ_width/self.viewArr.count;
        [button setTitle:self.viewArr[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateDisabled)];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleV addSubview:button];
        
        
        
               //默认点击第一个
        if (i == 0) {
            button.enabled = NO;
            self.selectBtn = button;
            //让按钮根据文字计算
            [button.titleLabel sizeToFit];
            self.redView.GHZ_width = button.titleLabel.GHZ_width;
            self.redView.GHZ_centerX = button.GHZ_centerX;
}
}
  
  [self.titleV addSubview:redView];
>>>>>>> fb00d37fa9bf626cfee2578e0dba0e990bc7e900
}

-(void)setupControlScroll{
    //不加导航栏高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.GHZ_width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
#pragma mark scrollView delegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加自控制器的view
   
    //当前索引
    NSInteger index = scrollView.contentOffset.x/scrollView.GHZ_width;
    //取出自控制器
    UITableViewController *vc = self.childViewControllers[index];
    CGFloat bottom = self.tabBarController.tabBar.GHZ_height;
    CGFloat top = CGRectGetMaxY(self.titleV.frame);
    //内边距
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.view.GHZ_x = scrollView.contentOffset.x;
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.GHZ_width;
    [self titleClick:self.titleV.subviews[index]];

}



//button点击方法
-(void)titleClick:(UIButton *)button{
    button.enabled = NO;
    self.selectBtn.enabled = YES;
     self.selectBtn = button;
   
       //红色底线动画
    [UIView animateWithDuration:0.25 animations:^{
        self.redView.GHZ_width = button.titleLabel.GHZ_width;
        self.redView.GHZ_centerX = button.GHZ_centerX;
    }];
       //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.GHZ_width;
    [self.contentView setContentOffset:offset animated:YES];
}
//导航设置
-(void)setuptheNav{
    self.view.backgroundColor = [UIColor blueColor];
  }


@end
