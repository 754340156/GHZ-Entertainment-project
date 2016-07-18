//
//  GHZCreamCommentViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCreamCommentViewController.h"
#import "GHZTopicCell.h"
#import "GHZTopic.h"
#import "GHZCommentModel.h"
#import "GHZCommentTableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking/AFNetworking.h>
@interface GHZCreamCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**  评论 */
@property (weak, nonatomic) IBOutlet UITextField *commentTextFiled;
/**  最热数据 */
@property (nonatomic,strong) NSMutableArray *hotCommentArray;
/**  最新数据 */
@property (nonatomic,strong) NSMutableArray *newsCommentArray;
/**  网络请求页码 */
@property (nonatomic,assign) NSInteger page;
@end

@implementation GHZCreamCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self setUpHeader];
    [self setNavigationBar];
    [self setTableView];
    [self setRefresh];
}
- (void)setUpHeader
{
    UIView *header = [[UIView alloc] init];
    GHZTopicCell *cell = [GHZTopicCell GHZ_viewFromXib];
    cell.topic = self.model;
    cell.frame = CGRectMake(0, 0, GHZScreenWidth, self.model.cellHeight);
    [cell layoutIfNeeded];
    [header addSubview:cell];
    header.GHZ_height = cell.GHZ_height + 10;
    header.GHZ_width = GHZScreenWidth;
    self.tableView.tableHeaderView = header;
}
- (void)setNavigationBar
{
    self.navigationItem.title = @"评论";
}
- (void)setTableView
{
//    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.tableView registerNib:[UINib nibWithNibName:@"GHZCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"GHZCommentTableViewCell"];
}
- (void)setRefresh
{
     __weak typeof(self)weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 1;
        [weakself  getCommentsWithID:[NSString stringWithFormat:@"%ld",self.model.ID] block:^(NSMutableArray *hotComments, NSMutableArray *lastestComments) {
            weakself.hotCommentArray = hotComments;
            weakself.newsCommentArray = lastestComments;
            [weakself.tableView reloadData];
            [weakself.tableView.mj_header endRefreshing];
        }];
        [weakself.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakself.page += 1;
        GHZCommentModel *comment = [weakself.newsCommentArray lastObject];
        [weakself getCommentsWithID:[NSString stringWithFormat:@"%ld",self.model.ID] page:self.page lastcid:comment.ID block:^(id json,NSInteger total) {
            
            NSMutableArray *array = [NSMutableArray array];
            for (GHZCommentModel *comment in json) {
                
                [array addObject:comment];
            }
            [weakself.newsCommentArray addObjectsFromArray:array];
            [weakself.tableView reloadData];
            if (weakself.newsCommentArray.count >= total) { // 全部加载完毕
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                // 结束刷新状态
                [weakself.tableView.mj_footer endRefreshing];
            }
        }];
    }];
    self.tableView.mj_footer.hidden = YES;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotCommentArray.count;
    NSInteger latestCount = self.newsCommentArray.count;
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotCommentArray.count;
    NSInteger latestCount = self.newsCommentArray.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHZCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GHZCommentTableViewCell"];
    cell.model = [self commentInIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self commentInIndexPath:indexPath].cellHeight;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotCommentArray.count;
    if (section == 0) {
        return hotCount ? @"最热评论" : @"最新评论";
    } else {
        return  @"最新评论";
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建menu菜单
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else {
        //取出点的那一行
        GHZCommentTableViewCell *cell = (GHZCommentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        //成为第一响应者
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        UIMenuItem *copy = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(copyText:)];
        menu.menuItems = @[ding,replay,report,copy];
        
        CGRect cellRect = CGRectMake(0, cell.GHZ_height / 2, cell.GHZ_width, cell.GHZ_height / 2);
        [menu setTargetRect:cellRect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    //让键盘退出
    [self.view endEditing:YES];
}
#pragma mark - 底部工具栏

- (IBAction)ClickVoiceAction:(UIButton *)sender
{
    
}
- (IBAction)ClickAtAction:(UIButton *)sender
{
    
}
- (GHZCommentModel *)commentInIndexPath:(NSIndexPath *)indexPath {
    
    return [self commentsInSection:indexPath.section][indexPath.row];
}
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotCommentArray.count ? self.hotCommentArray : self.newsCommentArray;
    }
    return self.newsCommentArray;
}
#pragma mark - menuController处理
- (void)ding:(UIMenuController *)menu {//顶
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, indexPath);
}

- (void)replay:(UIMenuController *)menu {//回复
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, indexPath);
}

- (void)report:(UIMenuController *)menu {//举报
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, indexPath);
}

- (void)copyText:(UIMenuController *)menu {//复制
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = [self commentInIndexPath:indexPath].content;
}
#pragma  mark - 懒加载
- (NSMutableArray *)hotCommentArray
{
    if (!_hotCommentArray) {
        _hotCommentArray = [NSMutableArray array];
    }
    return _hotCommentArray;
}
- (NSMutableArray *)newsCommentArray
{
    if (!_newsCommentArray) {
        _newsCommentArray = [NSMutableArray array];
    }
    return _newsCommentArray;
}
#pragma mark - 请求
-(void)getCommentsWithID:(NSString *)ID block:(void (^)(id, id))block
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = ID;
    params[@"hot"] = @"1";
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 如果没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            return;
        }
        //最热评论
        NSArray *hotCommentArray = [GHZCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        NSArray *lastestCommentArray = [GHZCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        block(hotCommentArray,lastestCommentArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)getCommentsWithID:(NSString *)ID page:(NSInteger)page lastcid:(NSString *)lastcid block:(void (^)(id, NSInteger))block{
     __weak typeof(self)weakself = self;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = ID;
    params[@"page"] = @(page);
    params[@"lastcid"] = lastcid;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         如果没有数据没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
             [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        //最热评论
        NSArray *moreCommentArray = [GHZCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSInteger total = [responseObject[@"total"] integerValue];
        block(moreCommentArray,total);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 键盘处理
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    //取出键盘最终的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 取出键盘弹出需要花费的时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改transform
    [UIView animateWithDuration:duration animations:^{
        CGFloat ty = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        self.view.transform = CGAffineTransformMakeTranslation(0, - ty);
    }];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
