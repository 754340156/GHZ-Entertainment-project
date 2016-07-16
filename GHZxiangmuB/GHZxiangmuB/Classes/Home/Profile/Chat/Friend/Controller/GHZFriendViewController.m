//
//  GHZFriendViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZFriendViewController.h"
#import "GHZChatViewController.h"
#import <EMSDK.h>
@interface GHZFriendViewController ()<EMUserListViewControllerDataSource,EMUserListViewControllerDelegate>
/**  数据源 */
@property (nonatomic,strong) NSMutableArray *userListArray;
@end

@implementation GHZFriendViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserList) name:kNotifyAgreeFriend object:nil ];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserList) name:kNotifyReceiveFriendAgree object:nil];
}

#pragma mark - 好友通知
- (void)refreshUserList
{
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark - EMUserListViewControllerDelegate
////联系人列表扩展样例
//- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
//                           modelForBuddy:(NSString *)buddy
//{
//    //用户可以根据自己的用户体系，根据buddy设置用户昵称和头像
//    id<IUserModel> model = nil;
//    model = [[EaseUserModel alloc] initWithBuddy:buddy];
//    model.avatarURLPath = @"";//头像网络地址
//    model.nickname = @"昵称";//用户昵称
//    return model;
//}
- (void)userListViewController:(EaseUsersListViewController *)userListViewController
            didSelectUserModel:(id<IUserModel>)userModel
{
    GHZChatViewController *chatVC = [[GHZChatViewController alloc] initWithConversationChatter:userModel.nickname conversationType:EMConversationTypeChat];
    [self.navigationController  presentViewController:chatVC animated:YES completion:^{
        
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)userListArray
{
    if (!_userListArray) {
        _userListArray = [NSMutableArray array];
    }
    return _userListArray;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
