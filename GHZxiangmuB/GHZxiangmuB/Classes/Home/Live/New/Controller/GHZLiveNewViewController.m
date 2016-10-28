//
//  GHZLiveNewViewController.m
//  GHZxiangmuB
//
//  Created by    on 16/7/7.
//  Copyright © 2016年  赵哲. All rights reserved.
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
    [self setADData];
    [self setRefresh];
}

- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.GHZ_height = GHZScreenHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
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
    //请求最新好友列表
    [manager GET:[NSString stringWithFormat:@"%@1",liveHotUrl] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [responseObject[@"data"][@"list"] writeToFile:userPlist atomically:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];

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
        currentPage++;
        [weakself setData];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden = YES;
}
#pragma mark - UITableViewDelegate
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     self.tableView.mj_footer.hidden = (self.dataArray.count == 0);
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
        livingVC.currentIndex = indexPath.row - 1;
        livingVC.livingModels = self.dataArray;
        [self presentViewController:livingVC animated:YES completion:^{
            
        }];
    }
}
#pragma mark - UIScrollViewDelegate
//当scrollView滚动的时候调用的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//     self.view.frame = CGRectMake(0, -20, GHZScreenWidth, GHZScreenHeight);
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer* pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity < -5) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
        //向上拖动，隐藏导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];

        [UIView animateWithDuration:0.4 animations:^{
            self.tabBarController.tabBar.transform =  CGAffineTransformMakeTranslation(0, 44);
        } completion:^(BOOL finished) {
             self.tabBarController.tabBar.hidden = YES;
        }];
    }
    else if (velocity > 5) {
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
#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GHZLiveWebViewController *webVC = [[GHZLiveWebViewController alloc] init];
    webVC.webUrl =  [self.ADArray[index] link];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
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
