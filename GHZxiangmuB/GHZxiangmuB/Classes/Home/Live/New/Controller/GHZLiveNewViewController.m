//
//  GHZLiveNewViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLiveNewViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "GHZNewTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "GHZLiveNewModel.h"
#import "GHZLiveWebViewController.h"
#import "GHZLivingViewController.h"
@interface GHZLiveNewViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
/**  头部轮播视图 */
@property (nonatomic,strong) SDCycleScrollView *headerCycleView;
/**  数据源 */
@property (nonatomic,strong) NSMutableArray *dataArray;
/**  顶部轮播数据源 */
@property (nonatomic,strong) NSMutableArray *ADArray;
@end

static NSInteger currentPage = 1;
@implementation GHZLiveNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self setADData];
    [self setRefresh];
}

- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.GHZ_height = self.view.GHZ_height - self.navigationController.navigationBar.GHZ_height - self.tabBarController.tabBar.GHZ_height - 20 ;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"GHZNewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GHZNewTableViewCell"];
    
}
- (void)setADData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getADUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            GHZLiveNewSCVModel *model = [[GHZLiveNewSCVModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.ADArray addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)setData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%ld",liveNewUrl,currentPage] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"msg"] isEqualToString:@"操作成功"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"list"]) {
                GHZLiveNewModel *model = [[GHZLiveNewModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }else
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            currentPage--;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        currentPage--;
    }];
    
}
- (void)setRefresh
{
     __weak typeof(self)weakself = self;
    currentPage = 1;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [weakself setData];
    }];
   self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [weakself setData];
       currentPage++;
   }];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - UITableViewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell  *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        self.headerCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, GHZScreenWidth, cycleSVWidth) delegate:self placeholderImage:[UIImage imageNamed:@"placeHolder_ad_414x100"]];
        NSMutableArray *array = [NSMutableArray array];
        for (GHZLiveNewSCVModel *model in self.ADArray) {
            [array addObject: model.imageUrl];
        }
        self.headerCycleView.imageURLStringsGroup = array.copy;
        [cell addSubview:self.headerCycleView];
        return cell;
    }
    GHZNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHZNewTableViewCell"];
    cell.model = self.dataArray[indexPath.row - 1];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cycleSVWidth;
    }
    return 440;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cycleSVWidth;
    }
    return 440;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        GHZLivingViewController *livingVC = [[GHZLivingViewController alloc] init];
        [self presentViewController:livingVC animated:YES completion:^{
            
        }];
    }
}
#pragma mark  - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GHZLiveWebViewController *webV = [[GHZLiveWebViewController alloc] init];
    
    webV.webUrl =  [self.ADArray[index] link];
    [self.navigationController pushViewController:webV animated:YES];
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (NSMutableArray *)ADArray
{
    if (!_ADArray) {
        _ADArray = [NSMutableArray array];
    }
    return _ADArray;
}







@end
