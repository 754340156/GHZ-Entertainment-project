//
//  GHZLivingViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLivingViewController.h"
#import "GHZLivingCollectionViewCell.h"
#import "GHZLivingUserView.h"
#import "GHZHotModel.h"
#import "GHZLiveNewModel.h"
#import <MJRefresh/MJRefresh.h>
@interface GHZLivingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**  collectionView */
@property (nonatomic,strong) UICollectionView *collectionView;

/**  点击头像推出的主播的详情 */
@property (nonatomic,weak) GHZLivingUserView *userView;
@end

@implementation GHZLivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickIcon:) name:kNotifyClickUser object:nil];
    [self setCollectionView];
    [self setRefresh];
}
- (void)setCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[GHZLivingCollectionViewCell class] forCellWithReuseIdentifier:@"GHZLivingCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}
// 点击头像通知
- (void)clickIcon:(NSNotification *)userInfo
{
    if (userInfo.userInfo[@"user"]) {
        
        if ([userInfo.userInfo[@"user"] isKindOfClass:[GHZHotModel class]]) {
             self.userView.hotModel  = userInfo.userInfo[@"user"];
        }else
        {
            self.userView.liveNewModel = userInfo.userInfo[@"user"];
        }
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:12 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.userView.center = self.view.center;
            self.userView.GHZ_size = CGSizeMake(livingUserWidth, livingUserHeight);
        } completion:^(BOOL finished) {
            self.userView.center = self.view.center;
            self.userView.GHZ_size = CGSizeMake(livingUserWidth, livingUserHeight);
        }];
    }
}
- (void)setRefresh
{
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        NSLog(@"上拉");
//    }];
//    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        
//    }];
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GHZLivingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHZLivingCollectionViewCell" forIndexPath:indexPath];
    cell.fatherVC = self;
    cell.live = self.livingModels[self.currentIndex];
    NSUInteger relateIndex = self.currentIndex;
    if (self.currentIndex + 1 == self.livingModels.count) {
        relateIndex = 0;
    }else{
        relateIndex += 1;
    }
    cell.relateLive = self.livingModels[relateIndex];
    cell.clickRelatedLive = ^{
        self.currentIndex += 1;
        [self.collectionView reloadData];
    };
    return cell;
}
#pragma mark - 懒加载 setOrGet
- (GHZLivingUserView *)userView
{
    if (!_userView) {
        _userView  = [GHZLivingUserView GHZ_viewFromXib];
        _userView.GHZ_centerX = self.view.center.x;
        _userView.GHZ_y = GHZScreenHeight;
        _userView.GHZ_size = CGSizeMake(livingUserWidth, livingUserHeight);
        [self.collectionView addSubview:_userView];
        _userView.closeAction = ^(UIButton *closeButton)
        {
            [UIView animateWithDuration:0.25 animations:^{
                _userView.GHZ_centerX = self.view.center.x;
                _userView.GHZ_y = GHZScreenHeight;
                _userView.GHZ_size = CGSizeMake(livingUserWidth, livingUserHeight);
            } completion:^(BOOL finished) {
                [_userView removeFromSuperview];
                _userView = nil;
            }];
        };
    }
    return _userView;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
