//
//  GHZTopicController.m
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZTopicController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "GHZTopic.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "GHZTopicCell.h"
#import "GHZCreamCommentViewController.h"
#import "UMSocial.h"
#import "GHZDataBaseHelper.h"
#import "GHZMBManager.h"
@interface GHZTopicController ()<GHZTopicCellDelegate,UMSocialUIDelegate>
/**
 *  帖子数据
 */
@property (nonatomic, strong) NSMutableArray *topics;
/**当前页码*/
@property (nonatomic, assign) NSInteger page;

/**当加载下一页数据时需要这个参数*/
@property(nonatomic,copy)  NSString *maxtime;
//上一次的请求数据
@property (nonatomic, strong) NSDictionary * params;

@end

@implementation GHZTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化表格
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
}
static NSString  *const GHZTopicCellId = @"topic";
- (void)setupTableView{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.GHZ_height;
    CGFloat top = GHZTitleVY + GHZTitleVH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GHZTopicCell class]) bundle:nil] forCellReuseIdentifier:GHZTopicCellId];
    
}

- (void)setupRefresh{
    
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_footer.hidden = YES;
    
}
#pragma mark - 数据处理
/**
 *  加载新的帖子数据
 */
- (void)loadNewTopics{
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =@(self.type);
    
    self.params = params;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *responseObject) {
        if (self.params != params) return ;
        //存储 maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典 -> 模型
        self.topics = [GHZTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //清空页码
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}

//先进行下拉刷新,再上拉刷新第五页的数据

//下拉刷新成功回来,只有一页数据, page = 0
//上拉刷新成功会拉 : 最前面那页 + 第五页数据

/**
 *  加载更多帖子数据
 */
- (void)loadMoreTopics{
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    //self.page++;
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] =@(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *responseObject) {
        if (self.params != params) return ;
        
        //存储 maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典 -> 模型
        NSArray *newTopics = [GHZTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        //设置页码
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHZTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:GHZTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    cell.delegate =self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出帖子的模型
    GHZTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}
#pragma mark - GHZTopicCellDelegate
//分享
- (void)getClick:(NSString *)image url:(NSString *)url text:(NSString *)text{
    if (!(self.type == Word)) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:image];

    }
    [UMSocialData defaultData].extConfig.title = text;
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = url;
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"57490f1ee0f55a75d5002f3f" shareText:[NSString stringWithFormat:@"%@%@",text,url] shareImage:[UIImage imageNamed:@"icon"] shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone] delegate:self];
}
//分享完成后的回调函数
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{

    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0] );
    }
}
//评论
- (void)getCommentClickWithModel:(GHZTopic *)model
{
    GHZCreamCommentViewController *creamCommentVC = [[GHZCreamCommentViewController alloc] init];
    creamCommentVC.hidesBottomBarWhenPushed = YES;
    creamCommentVC.model = model;
    [self.navigationController pushViewController:creamCommentVC animated:YES];
}
//收藏
- (void)getCollectClickWithModel:(GHZTopic *)model
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle: nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];//创建界面
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]; //创建按钮cancel以及对应事件
    UIAlertAction *saveAction=[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[GHZDataBaseHelper shareInstance] create];
        if ([[GHZDataBaseHelper shareInstance] isExistsWithTopicID:model.ID] ) {
            [GHZMBManager showBriefAlert:@"已收藏"];
        }else
        {
            [[GHZDataBaseHelper shareInstance] insertTopic:model];
            [GHZMBManager showBriefAlert:@"收藏成功"];
        }
        
    }];//创建按钮ok以及对应事件
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    //最后将这些按钮都添加到界面上去，显示界面
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    [alertController addAction:report];
    [self presentViewController: alertController animated:YES completion:nil];
}
#pragma mark - 懒加载

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
@end
