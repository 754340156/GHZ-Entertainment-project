//
//  GHZCareViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCareViewController.h"
#import "GHZCareHeaderView.h"
#import "GHZLiveViewController.h"
#import "GHZSelectedView.h"
@interface GHZCareViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
/**  头视图 */
@property (nonatomic,strong) GHZCareHeaderView *headerView;
@end

@implementation GHZCareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
}
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   return self.headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}
#pragma mark - UIScrollViewDelegate
//当scrollView滚动的时候调用的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer* pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity < -5 ) {
        //向上拖动，隐藏导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
        [UIView animateWithDuration:0.4 animations:^{
            self.tabBarController.tabBar.transform =  CGAffineTransformMakeTranslation(0, 44);
        } completion:^(BOOL finished) {
            self.tabBarController.tabBar.hidden = YES;
        }];
    }
    else if (velocity > 5 ) {
        //向下拖动，显示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
        [UIView animateWithDuration:0.4 animations:^{
            self.tabBarController.tabBar.hidden = NO;
            self.tabBarController.tabBar.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }
    else if(velocity==0){
        //停止拖拽
    }
}
#pragma mark - 懒加载
- (GHZCareHeaderView *)headerView
{
     __weak typeof(self)weakself = self;
    if (!_headerView) {
        _headerView = [GHZCareHeaderView GHZ_viewFromXib];
        _headerView.lookUserAction = ^(UIButton *sender)
        {
            //滚到首页
            GHZLiveViewController *liveVC  = (GHZLiveViewController *)weakself.parentViewController;
            [liveVC.contentView setContentOffset:CGPointMake(0, -64) animated:YES];
            liveVC.topMenuView.underLine.GHZ_x = 15;
            liveVC.topMenuView.selectedType = HomeTypeHot;
        };
    }
    return _headerView;
}
@end
