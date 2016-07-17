//
//  GHZNewCollectionView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewCollectionView.h"
#import "GHZNewWordCell.h"
#import "AFNetWorking.h"
#import "GHZTopicModel.h"
#import "MJExtension.h"
@interface GHZNewCollectionView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *clloctionArr;

@end

@implementation GHZNewCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = GHZRGBColor(223, 223, 223);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self lodingdata];
    [self.tableView registerNib:[UINib nibWithNibName:@"GHZNewWordCell" bundle:nil] forCellReuseIdentifier:@"GHZNewWordCell"];
}
-(void)lodingdata{
    //参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"a"] = @"newlist";
    dic[@"c"] = @"data";
    dic[@"type"] = @"1";
    //self.params = dic;
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.clloctionArr = [GHZTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.clloctionArr.count;
    ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GHZTopicModel *model = self.clloctionArr[indexPath.row];
    return model.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GHZNewWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHZNewWordCell"];
    cell.model = self.clloctionArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
