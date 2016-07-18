//
//  GHZCollctionListViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCollctionListViewController.h"
#import "GHZCollectionView.h"
#import "GHZNewCollectionView.h"
@interface GHZCollctionListViewController ()<UIScrollViewDelegate>
/**  分段 */
@property (nonatomic,strong)UISegmentedControl *segmentedControl;
/**  scrollView */
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation GHZCollctionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self setChildViewController];
}
- (void)setChildViewController
{
    //精华
    GHZCollectionView * creamVC = [[GHZCollectionView alloc] init];
    creamVC.view.frame = CGRectMake(0, 0, GHZScreenWidth, GHZScreenHeight);
    [self.scrollView addSubview:creamVC.view];
    [self addChildViewController:creamVC];
    //新帖
    GHZNewCollectionView *newVC = [[GHZNewCollectionView alloc] init];
    newVC.view.frame = CGRectMake(GHZScreenWidth, 0, GHZScreenWidth, GHZScreenHeight);
    [self addChildViewController:newVC];
    [self.scrollView addSubview:newVC.view];
}
#pragma mark - get  set
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, GHZScreenWidth, GHZScreenHeight)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        //方向锁
        _scrollView.directionalLockEnabled = YES;
        //取消自动布局
        self.automaticallyAdjustsScrollViewInsets = NO;
        _scrollView.contentSize = CGSizeMake(GHZScreenWidth * 2, 0);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"精华",@"新帖"]];
        _segmentedControl.GHZ_width = 150;
        [_segmentedControl addTarget:self action:@selector(segmentSelect:) forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = _segmentedControl;
    }
    return _segmentedControl;
}
#pragma mark scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger ratio = scrollView.contentOffset.x / GHZScreenWidth;
    self.segmentedControl.selectedSegmentIndex = ratio;
}
- (void)segmentSelect:(UISegmentedControl *)seg
{
    [self.scrollView setContentOffset:CGPointMake(seg.selectedSegmentIndex * GHZScreenWidth, 0) animated:YES];
}
@end
