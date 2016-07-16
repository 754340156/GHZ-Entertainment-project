//
//  GHZCollectionView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCollectionView.h"
#import "GHZNewWordCell.h"
#import "AFNetWorking.h"
#import "GHZTopicModel.h"
#import "MJExtension.h"
@interface GHZCollectionView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *clloctionArr;
@end

@implementation GHZCollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(10, 20, 30, 30);
    button.backgroundColor = [UIColor clearColor];
    button.imageView.image =[UIImage imageNamed:@"show_image_back_icon"];
    [button setImage:[UIImage imageNamed:@"show_image_back_icon"] forState:(UIControlStateNormal)];
    [self.view addSubview:button];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [button addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
    UILabel *title = [[UILabel alloc] init];
   
    [self.view addSubview:title];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, GHZScreenWidth, GHZScreenHeight) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = GHZRGBColor(223, 223, 223);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self lodingdata];
    [self.tableView registerNib:[UINib nibWithNibName:@"GHZNewWordCell" bundle:nil] forCellReuseIdentifier:@"GHZNewWordCell"];
}
-(void)btnAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return cell;

    
}

@end
