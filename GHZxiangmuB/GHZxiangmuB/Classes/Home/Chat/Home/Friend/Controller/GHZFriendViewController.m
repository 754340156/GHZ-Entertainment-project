//
//  GHZFriendViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZFriendViewController.h"

@interface GHZFriendViewController ()<EMUserListViewControllerDelegate,EMUserListViewControllerDataSource,EMContactManagerDelegate>
/**  数据源 */
@property (nonatomic,strong) NSMutableArray *userListArray;
@end

@implementation GHZFriendViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[EMClient sharedClient].contactManager removeDelegate:self];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;

//    self.showSearchBar = YES;
    
    [self setUserListArray];
    
}
- (void)setUserListArray
{
    //从数据库加载好友
    [self.dataArray addObject:[[EMClient sharedClient].contactManager getContactsFromDB]];
    //从服务器获取好友列表
    [[EMClient sharedClient].contactManager asyncGetContactsFromServer:^(NSArray *aList) {
        //替换
        [self.userListArray removeLastObject];
        [self.userListArray addObject:aList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(EMError *aError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"从服务器获取好友列表失败%@",aError.errorDescription);
        });
    }];
}

#pragma mark - EMUserListViewControllerDelegate
- (void)userListViewController:(EaseUsersListViewController *)userListViewController
            didSelectUserModel:(id<IUserModel>)userModel
{
    NSLog(@"点击选中的user%@",userModel);
}
//- (NSInteger)numberOfRowInUserListViewController:(EaseUsersListViewController *)userListViewController
//{
//    return 1;
//}
//联系人列表扩展样例
- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
                   userModelForIndexPath:(NSIndexPath *)indexPath
{
    //用户可以根据自己的用户体系，根据buddy设置用户昵称和头像
    id<IUserModel> model = nil;
    model = [[EaseUserModel alloc] init];
    model.avatarURLPath = @"";//头像网络地址
    model.nickname = @"昵称";//用户昵称
    return model;
}
#pragma mark - EMContactManagerDelegate
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@%@",aUsername,aMessage]preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:@"8001"];
        if (!error) {
            NSLog(@"发送拒绝成功");
        }
    }];
    [controller addAction:cancleAction];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!error) {
            NSLog(@"发送同意成功");
        }
    }];
    [controller addAction:doAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@同意了你的好友请求",aUsername]preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [controller addAction:doAction];
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@拒绝了你的好友请求",aUsername]preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
    }];
    [controller addAction:doAction];
    [self presentViewController:controller animated:YES completion:nil];
}
#pragma mark - 懒加载
- (NSMutableArray *)userListArray
{
    if (!_userListArray) {
        _userListArray = [NSMutableArray array];
    }
    return _userListArray;
}
@end
