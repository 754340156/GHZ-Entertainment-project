//
//  GHZWordViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZWordViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "GHZTopic.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "GHZTopicCell.h"


@interface GHZWordViewController ()
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

@implementation GHZWordViewController

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;

}



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
//    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
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
    params[@"type"] = @"29";
    
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
    params[@"type"] = @"29";
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
//        //恢复页码
//        self.page--;
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHZTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:GHZTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}


#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
