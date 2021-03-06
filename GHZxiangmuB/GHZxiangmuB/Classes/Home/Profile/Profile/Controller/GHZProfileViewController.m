//
//  GHZProfileViewController.m
//  GHZxiangmuB
//
//  Created by    on 16/7/13.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZProfileViewController.h"
#import "GHZProfileHeaderView.h"
#import "GHZChatHomeViewController.h"
#import "GHZNavViewController.h"
#import "GHZLoginViewController.h"
#import "GHZFileDataHandle.h"
#import "GHZCollctionListViewController.h"
#import "GHZCollectionView.h"
#import <EMSDK.h>
#import "GHZMBManager.h"
@interface GHZProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
/**  头视图 */
@property (nonatomic,weak) GHZProfileHeaderView *headerView;
@end

@implementation GHZProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, GHZScreenWidth, GHZScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_new_bg_live"]];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"";
            break;
        case 1:
            cell.textLabel.text = @"收藏";
            break;
        case 2:
            cell.textLabel.text = @"清除缓存";
            cell.accessoryView = [self createClearLabel];
            break;
        case 3:
            cell.textLabel.text = @"";
            break;
        case 4:
            cell.textLabel.text = @"退出";
            break;
    }

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {

    }
    else if (indexPath.row == 1)
    {
        GHZCollctionListViewController *CollctionListVC = [[GHZCollctionListViewController alloc] init];
        CollctionListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:CollctionListVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要清除缓存吗?" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [controller addAction:cancleAction];
        UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[GHZFileDataHandle shareInstance] clearDisk];
            [self.tableView reloadData];
        }];
        [controller addAction:doAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else if (indexPath.row == 3)
    {
        
    }
    else if (indexPath.row == 4)
    {
         __weak typeof(self)weakself = self;
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出程序吗?" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [controller addAction:cancleAction];
        UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [[EMClient sharedClient] asyncLogout:YES success:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [GHZMBManager showBriefAlert:@"退出成功"];
                    //跳到主界面
                    weakself.view.window.backgroundColor = [UIColor grayColor];
                    GHZNavViewController *navVC = [[GHZNavViewController alloc] initWithRootViewController:[[GHZLoginViewController alloc]init]];
                    weakself.view.window.rootViewController = navVC;
                    [weakself.view.window makeKeyAndVisible];
                });
            } failure:^(EMError *aError) {
                [GHZMBManager showBriefAlert:@"退出失败"];
            }];
        }];
        [controller addAction:doAction];
        [self presentViewController:controller animated:YES completion:nil];

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
#pragma mark - tools
//创建缓存的label
- (UILabel *)createClearLabel
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    label.textColor = [UIColor grayColor];
    label.text = [NSString stringWithFormat:@"%.2lfM",[[GHZFileDataHandle shareInstance] getDiskSize]];
    return label;
}
#pragma mark - 懒加载
- (GHZProfileHeaderView *)headerView
{
    __weak typeof(self)weakself = self;
    if (!_headerView) {
        _headerView = [GHZProfileHeaderView GHZ_viewFromXib];
        _headerView.chatAction = ^(UIButton *sender)
        {
            //跳到聊天界面
            GHZChatHomeViewController *chatHomeVC = [[GHZChatHomeViewController alloc] init];
            chatHomeVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:chatHomeVC animated:YES];
        };
    }
    return _headerView;
}
@end
