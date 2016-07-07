//
//  GHZLeftViewController.m
//  xiangmu
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLeftViewController.h"
#import "GHZTabBarViewController.h"
#import "GHZNavViewController.h"
#import "AppDelegate.h"
#import "Text1ViewController.h"
#import "Text2ViewController.h"

@interface GHZLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation GHZLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self setTableView];
}
- (void)setTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 200, 200, 300) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld,%ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    switch (indexPath.row) {
        case 0:
            [appDelegate.drawerController setCenterViewController:[[GHZTabBarViewController alloc]init]withFullCloseAnimation:YES completion:^(BOOL finished) {
            }];
            break;
        case 1:
            [appDelegate.drawerController setCenterViewController:[[GHZNavViewController alloc]initWithRootViewController:[[Text1ViewController alloc]init]] withFullCloseAnimation:YES completion:^(BOOL finished) {
            }];
            break;
        case 2:
            [appDelegate.drawerController setCenterViewController:[[GHZNavViewController alloc]initWithRootViewController:[[Text2ViewController alloc]init]]withFullCloseAnimation:YES completion:^(BOOL finished) {
            }];
            break;
    }
}

@end
