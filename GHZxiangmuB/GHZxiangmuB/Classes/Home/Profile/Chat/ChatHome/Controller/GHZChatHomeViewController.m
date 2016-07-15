//
//  GHZChatHomeViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZChatHomeViewController.h"
#import "GHZConversationViewController.h"
#import "GHZFriendViewController.h"
#import "GHZAddFriendViewController.h"
#import "GHZAssistViewController.h"
#import "GHZSeletedChatView.h"
#import "GHZOutPutView.h"
#import "SubLBXScanViewController.h"
#import <EMSDK.h>
@interface GHZChatHomeViewController ()<UIScrollViewDelegate,GHZOutPutViewDelegate,EMContactManagerDelegate>
/**  ScrollView */
@property (nonatomic,strong)UIScrollView *contentView;
/**  顶部选择器 */
@property (nonatomic,strong) GHZSeletedChatView *topMenuView;
/**  outputView */
@property (nonatomic,strong) GHZOutPutView *outputView;
@end

@implementation GHZChatHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScrollView];
    [self setChildViewController];
    [self setNavigationItem];
    [self setTopMenuView];
    [self scrollViewDidEndScrollingAnimation:self.contentView];
    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topMenuView.hidden = NO;
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.topMenuView.hidden = YES;
    [[EMClient sharedClient].contactManager removeDelegate:self];
}
- (void)setChildViewController
{
    GHZConversationViewController *newVC = [[GHZConversationViewController alloc] init];
    [self addChildViewController:newVC];
    
    GHZFriendViewController *hotVC = [[GHZFriendViewController alloc] init];
    [self addChildViewController:hotVC];
    
    GHZAssistViewController *careVC = [[GHZAssistViewController alloc] init];
    [self addChildViewController:careVC];
}
- (void)setScrollView
{
    self.contentView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.contentView.contentSize = CGSizeMake(GHZScreenWidth * 3, 0);
    // 去掉滚动条
    self.contentView.showsVerticalScrollIndicator = NO;
    self.contentView.showsHorizontalScrollIndicator = NO;
    // 设置分页
    self.contentView.pagingEnabled = YES;
    // 设置代理
    self.contentView.delegate = self;
    // 去掉弹簧效果
    self.contentView.bounces = NO;
    
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.contentView];
}
// 设置顶部选择器
- (void)setTopMenuView
{
    self.topMenuView = [[GHZSeletedChatView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.topMenuView.GHZ_x = 45;
    self.topMenuView.GHZ_width = GHZScreenWidth - 45 * 2;
    __weak typeof(self)weakself = self;
    self.topMenuView.selectedBlock = ^(HomeType type)
    {
        [weakself.contentView setContentOffset:CGPointMake(type * GHZScreenWidth, -64)  animated:YES];
    };
    [self.navigationController.navigationBar addSubview:self.topMenuView];
    
}
- (void)setNavigationItem
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriendAction)];
}
//添加好友
- (void)addFriendAction
{
    [self.outputView pop];
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.GHZ_width;
    
    // 取出子控制器
    GHZViewController *vc = self.childViewControllers[index];
    vc.view.GHZ_x = scrollView.contentOffset.x;
    vc.view.GHZ_y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.GHZ_height = scrollView.GHZ_height;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    CGFloat page = scrollView.contentOffset.x / GHZScreenWidth;
    CGFloat offsetX = scrollView.contentOffset.x / GHZScreenWidth * (self.topMenuView.GHZ_width * 0.5 - Home_Seleted_Item_W * 0.5 - 15);
    self.topMenuView.underLine.GHZ_x = 15 + offsetX;
    if (page == 1 ) {
        self.topMenuView.underLine.GHZ_x = offsetX + 10;
    }else if (page > 1){
        self.topMenuView.underLine.GHZ_x = offsetX + 5;
    }
    self.topMenuView.selectedType = (int)(page + 0.5);
}
#pragma mark - GHZOutPutViewDelegate
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1)
    {
        GHZAddFriendViewController *addFriendVC =[[GHZAddFriendViewController alloc] init];
        [self.navigationController pushViewController:addFriendVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        [self setStyle];
    }
    else if (indexPath.row == 3)
    {
        
    }
}
#pragma mark - 二维码
- (void)setStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 3;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    style.animationImage = imgLine;
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (GHZOutPutView *)outputView
{
    if (!_outputView) {
        GHZCellModel *one = [[GHZCellModel alloc] initWithTitle:@"发起群聊" imageName:@"contacts_add_newmessage"];
        GHZCellModel *two = [[GHZCellModel alloc] initWithTitle:@"添加好友" imageName:@"contacts_add_friend"];
        GHZCellModel *three = [[GHZCellModel alloc] initWithTitle:@"扫一扫" imageName:@"contacts_add_scan"];
        GHZCellModel *four = [[GHZCellModel alloc] initWithTitle:@"收付款" imageName:@"receipt_payment_icon"];
        NSArray *array = @[one,two,three,four];
        _outputView = [[GHZOutPutView alloc] initWithDataArray:array origin:CGPointMake(GHZScreenWidth -20, 64 +10) width:140 height:44 direction:GHZOutPutViewDirectionRight];
        _outputView.delegate = self;
        _outputView.dismissOperation = ^(){
            _outputView = nil;
        };
    }
    return _outputView;
}
#pragma mark - EMContactManagerDelegate
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@%@",aUsername,aMessage]preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:aUsername];
        if (!error) {
            NSLog(@"发送拒绝成功");
        }
    }];
    [controller addAction:cancleAction];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!error) {
            NSLog(@"发送同意成功");
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyAgreeFriend object:nil];
        }
    }];
    [controller addAction:doAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveAgreedFromUsername:(NSString *)aUsername
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@同意了你的好友请求",aUsername]preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *doAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyReceiveFriendAgree object:nil];
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
@end
