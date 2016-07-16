//
//  GHZCollctionListViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCollctionListViewController.h"
#import "GHZCollectionView.h"
#import "GHZNewCollectionView.h"
@interface GHZCollctionListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)UISegmentedControl *segmentedControl;
@end

@implementation GHZCollctionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"精华",@"最新"]];
    self.segmentedControl.frame = CGRectMake(100, 60, 150, 50);
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:self.segmentedControl];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)segmentAction:(id)sender{
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *segment = sender;
        if (segment.selectedSegmentIndex==0) {
            
        }else if (segment.selectedSegmentIndex==1){
 
        }
  
    }
 
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.arr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        GHZCollectionView *VC = [[GHZCollectionView alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else
        if (indexPath.row==1) {
            GHZNewCollectionView *VC = [[GHZNewCollectionView alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
