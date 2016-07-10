//
//  GHZHotViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZHotViewController.h"
#import "GHZHotModel.h"
#import "GHZLiveNewModel.h"
#import "GHZHotCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
#import "GHZLivingViewController.h"
@interface GHZHotViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
/**  记录当前页码 */
@property (nonatomic,assign) NSInteger currentPage;
/**  数据源 */
@property (nonatomic,strong) NSMutableArray *dataArray;
/**  自动刷新 */
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation GHZHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCollectionView];
    [self setRefresh];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //定时刷新
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(autoRefresh) userInfo:nil repeats:YES];
   
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)autoRefresh
{
    [self.collectionView.mj_header beginRefreshing];
}
- (void)setCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.itemSize = CGSizeMake((GHZScreenWidth-14)/3, (GHZScreenWidth-14)/3);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GHZHotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"GHZHotCollectionViewCell"];
}
- (void)setRefresh
{
     __weak typeof(self)weakself = self;
    self.currentPage = 1;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.currentPage = 1;
        [weakself setData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.currentPage++;
        [weakself setData];
    }];
    [self.collectionView.mj_header beginRefreshing];
}
- (void)setData
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%ld",liveHotUrl,self.currentPage] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            for (NSDictionary *dic in responseObject[@"data"][@"list"]) {
                GHZHotModel *model = [[GHZHotModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            [self.collectionView reloadData];
        }else
        {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            self.currentPage--;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        self.currentPage--;
    }];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GHZHotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHZHotCollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GHZLivingViewController *livingVC = [[GHZLivingViewController alloc] init];
    NSMutableArray *arr = [NSMutableArray array];
    for (GHZHotModel *model in self.dataArray) {
        GHZLiveNewModel *live = [[GHZLiveNewModel alloc] init];
        live.bigpic = model.photo;
        live.myname = model.nickname;
        live.smallpic = model.photo;
        live.gps = model.position;
        live.useridx = model.useridx;
        live.allnum = model.allnum;
        live.flv = model.flv;
        [arr addObject:live];
    }
    livingVC.currentIndex = indexPath.row;
    livingVC.livingModels = arr;
    [self presentViewController:livingVC animated:YES completion:^{
    }];
}
#pragma mark - UIScrollViewDelegate
//当scrollView滚动的时候调用的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer* pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
    if (velocity<-5) {
        //向上拖动，隐藏导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:0.4 animations:^{
            self.tabBarController.tabBar.transform =  CGAffineTransformMakeTranslation(0, 44);
        } completion:^(BOOL finished) {
            self.tabBarController.tabBar.hidden = YES;
        }];
    }
    else if (velocity>5) {
        //向下拖动，显示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
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
- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
