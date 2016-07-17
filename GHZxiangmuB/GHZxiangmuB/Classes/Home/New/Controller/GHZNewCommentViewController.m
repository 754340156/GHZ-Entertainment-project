//
//  GHZNewCommentViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewCommentViewController.h"

@interface GHZNewCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**  评论 */
@property (weak, nonatomic) IBOutlet UITextField *commentTextFiled;
/**  数据源 */
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation GHZNewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setTableView];
}
- (void)setTableView
{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
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
#pragma mark - 底部工具栏

- (IBAction)ClickVoiceAction:(UIButton *)sender
{
    
}
- (IBAction)ClickAtAction:(UIButton *)sender
{
    
}
#pragma  mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
