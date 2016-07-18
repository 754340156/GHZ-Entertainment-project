//
//  GHZAddFriendViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZAddFriendViewController.h"
#import "GHZResultTableViewController.h"
#import "GHZMBManager.h"
#import <EMSDK.h>
@interface GHZAddFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong)UISearchController *searchController;
/**  <#Description#> */
@property (nonatomic,strong) UITableView *tableView;
/**  数据源 */
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation GHZAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
}
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GHZScreenWidth, GHZScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma  mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.detailTextLabel.text = self.dataArray[indexPath.row][@"detail"];
    cell.imageView.image = [UIImage imageNamed:self.dataArray[indexPath.row][@"imageIcon"]];
    cell.textLabel.text = self.dataArray[indexPath.row][@"text"];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchController.searchBar;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma  mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [[EMClient sharedClient].contactManager  asyncAddContact:searchBar.text message:@"想要加你为好友" success:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [GHZMBManager showBriefAlert:@"发送好友请求成功"];
        });
        
    } failure:^(EMError *aError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [GHZMBManager showBriefAlert:[NSString stringWithFormat:@"发送好友请求失败%u",aError.code]];
        });
    }];
}
#pragma  mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@{@"detail":@"雷达加朋友",@"imageIcon":@"add_friend_icon_reda",@"text":@"添加身边的朋友"},
                       @{@"detail":@"面对面建群",@"imageIcon":@"add_friend_icon_addgroup",@"text":@"与身边的朋友进入同一个群聊"},
                       @{@"detail":@"扫一扫",@"imageIcon":@"add_friend_icon_scanqr",@"text":@"扫描二维码名片"},
                       @{@"detail":@"手机联系人",@"imageIcon":@"add_friend_icon_contacts",@"text":@"手机通讯录中的朋友"},
                       @{@"detail":@"公众号",@"imageIcon":@"add_friend_icon_offical",@"text":@"获取更多咨询和服务"}
                       ].mutableCopy;
    }
    return _dataArray;
}
- (UISearchController *)searchController
{
    if (!_searchController) {
        GHZResultTableViewController *resultVC = [[GHZResultTableViewController alloc] init];
        resultVC.view.frame = CGRectMake(0, 0, GHZScreenWidth, GHZScreenHeight);
        _searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
        _searchController.searchBar.delegate = self;
        _searchController.searchBar.placeholder = @"请输入好友的名字";
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchBar.frame = CGRectMake(_searchController.searchBar.frame.origin.x, _searchController.searchBar.frame.origin.y, _searchController.searchBar.frame.size.width, 44.0);
    }
    return _searchController;
}

@end
