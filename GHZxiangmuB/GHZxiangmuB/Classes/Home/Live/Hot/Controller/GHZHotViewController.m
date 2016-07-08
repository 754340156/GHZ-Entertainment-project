//
//  GHZHotViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZHotViewController.h"
#import "GHZHotModel.h"
#import "GHZHotCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>

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
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -108) collectionViewLayout:flowLayout];
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
    weakself.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
#pragma mark - 懒加载
- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
