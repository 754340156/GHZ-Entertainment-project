//
//  GHZRootViewController.m
//  xiangmu
//
//  Created by    on 16/7/6.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZCreamViewController.h"


#import "GHZTopicController.h"



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
    self.view.backgroundColor = BackColor;
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
    
    GHZTopicController *all = [GHZTopicController new];
    all.title = @"全部";
    all.type = All;
    [self addChildViewController:all];
    
    GHZTopicController *video = [GHZTopicController new];
    video.title = @"视频";
    video.type = Video;
    [self addChildViewController:video];
    
    GHZTopicController *voice = [GHZTopicController new];
    voice.title = @"声音";
    voice.type = Music;
    [self addChildViewController:voice];
    
    GHZTopicController *picture = [GHZTopicController new];
    picture.title = @"图片";
    picture.type = Picture;
    [self addChildViewController:picture];
    
    GHZTopicController *word = [GHZTopicController new];
    word.title = @"段子";
    word.type = Word;
    [self addChildViewController:word];
}
/**
 *  设置顶部的标签栏
 */
- (void)setupTitleView{
    
    //标题栏整体
    UIView *titleView = [[UIView alloc] init];

    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.GHZ_width = self.view.GHZ_width;
    titleView.GHZ_height = GHZTitleVH;
    titleView.GHZ_y = GHZTitleVY;
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = NavBarColor;
    indicatorView.GHZ_height = 2;
    indicatorView.tag = -1;
    indicatorView.GHZ_y = titleView.GHZ_height - indicatorView.GHZ_height;
    
    self.indicatorView = indicatorView;
    
    
    //内部的子标签
    
    CGFloat width = titleView.GHZ_width / self.childViewControllers.count;
    CGFloat height = titleView.GHZ_height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.GHZ_height = height;
        button.GHZ_width = width;
        button.GHZ_x = i *  width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:NavBarColor forState:(UIControlStateDisabled)];
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
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:nil action:nil];
}

- (void)tagClick{
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//添加自控制的 view
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.GHZ_width;

    //取出控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.GHZ_x = scrollView.contentOffset.x;
    vc.view.GHZ_y = 0;  //设置控制的y 值等于0(默认是20)
    vc.view.GHZ_height = scrollView.GHZ_height; //设置控制器 view 的 height 值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    [scrollView addSubview:vc.view];
 }


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.GHZ_width;
    [self titleClick:self.titlesView.subviews[index]];
}




@end
