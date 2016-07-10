//
//  GHZNewVideoViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//
//**********************************文字
#import "GHZNewVideoViewController.h"
#import "AFNetWorking.h"
#import "UIImageView+WebCache.h"
#import "GHZTopicModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "GHZNewWordCell.h"
@interface GHZNewVideoViewController ()
/** 段子*/
@property (nonatomic,strong)NSMutableArray *topics;
/** 当前页数*/
@property (nonatomic,assign)NSInteger page;
/** 加载下一页的参数*/
@property (nonatomic,copy)NSString *maxtime;
/** 上一次请求的参数*/
@property (nonatomic,strong)NSDictionary *params;
@end

@implementation GHZNewVideoViewController
-(NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化
    [self setupTable];
    
    //添加下拉刷新
    [self addRefresh];
    
    
    
    
}

-(void)setupTable{
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    CGFloat bottom = self.tabBarController.tabBar.GHZ_height;
    CGFloat top = GHZTitleVH+GHZTitleVY;
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GHZNewWordCell" bundle:nil] forCellReuseIdentifier:@"GHZNewWordCell"];
    
}

-(void)addRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadingData)];
    //自动改变透明
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingAddData)];
    
}

/**
 * 加载数据
 */
-(void)loadingData{
    
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    
    //参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"newlist";
    dic[@"c"] = @"data";
    dic[@"type"] = @"41";
    self.params = dic;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (self.params!=dic) {
            return ;
        }
        self.topics = [GHZTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        self.page = 0;//页码
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (self.params!=dic) {
            return ;
        }
        [self.tableView.mj_header endRefreshing];
    }];
    
}

//先下拉 在上拉

//下拉刷新回来:只有一页数据,page 0



//上拉刷新成功回来:最前面页 加第5页

/**
 * 下拉加载新数据
 */
-(void)loadingAddData{
    //结束下拉
    [self.tableView.mj_header endRefreshing];
    self.page++;
    //参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"newlist";
    dic[@"c"] = @"data";
    dic[@"type"] = @"41";
    NSInteger page = self.page +1;
    dic[@"page"] = @(page);
    dic[@"maxtime"] = self.maxtime;
    self.params = dic;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (self.params!=dic) {
            return ;
        }
        //字典转模型
        NSMutableArray *newtopics = [GHZTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newtopics];
        //获取maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        self.page = page; //加载成功page
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params!=dic) {
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"%@",error);

    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count==0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GHZNewWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHZNewWordCell" forIndexPath:indexPath];
    GHZTopicModel *dic = self.topics[indexPath.row];
    cell.model = dic;
    //    cell.textLabel.text = dic.name;
    //    cell.detailTextLabel.text = dic.text;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic.profile_image] placeholderImage:[UIImage imageNamed:@"Default"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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

