//
//  GHZLiveNewViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLiveNewViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
@interface GHZLiveNewViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
/**  头部轮播视图 */
@property (nonatomic,strong) SDCycleScrollView *headerCycleView;
@end

@implementation GHZLiveNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self setHeaderView];
}
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}
- (void)setHeaderView
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    self.headerCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, GHZScreenWidth, cycleSVWidth) delegate:self placeholderImage:[UIImage imageNamed:cycleSVPlaceHolder]];
    self.headerCycleView.imageURLStringsGroup = @[
                                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                                  ];
    return self.headerCycleView;
}
#pragma mark  - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);

}













@end
