//
//  GHZLivingTopView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLivingTopView.h"
#import "UIImage+Extension.h"
#import "GHZHotModel.h"
#import "GHZLiveNewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDWebImageDownloader.h>
@interface GHZLivingTopView ()
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personsLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeOrOpenButton;
@property (weak, nonatomic) IBOutlet UIScrollView *iconsScrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;
/**  一共直播的数组 */
@property (nonatomic,strong) NSMutableArray *userArray;
@end


@implementation GHZLivingTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self maskViewToBounds:self.countButton];
    [self maskViewToBounds:self.closeOrOpenButton];
    [self maskViewToBounds:self.iconImageView];
    [self maskViewToBounds:self.backView];
    
    //头像描边宽度颜色
    self.iconImageView.layer.borderWidth = iconBoundWidth;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //设置开启关闭按钮
    [self setCloseOrOpenButton];
    //设置scrollView
    [self setScrollView];
}
- (void)setCloseOrOpenButton
{
    [self.closeOrOpenButton setBackgroundImage:[UIImage imageWithColor:KeyColor size:self.closeOrOpenButton.GHZ_size] forState:UIControlStateNormal];
    [self.closeOrOpenButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:self.closeOrOpenButton.GHZ_size] forState:UIControlStateSelected];
    //默认关闭
    [self closeOrOpenAction:self.closeOrOpenButton];
}
- (void)setScrollView
{
    self.iconsScrollView.contentSize = CGSizeMake(self.iconsScrollView.GHZ_height * self.userArray.count, 0);
    CGFloat width = self.iconsScrollView.GHZ_height - DefaultMargin;
    CGFloat x = 0;
    for (int i = 0; i<self.userArray.count; i++) {
        x = 0 + (DefaultMargin + width) * i;
        UIImageView *userView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 5, width, width)];
        [self maskViewToBounds:userView];
        GHZHotModel *user = self.userArray[i];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                userView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:iconBoundWidth];
            });
        }];
        // 给每个用户添加手势
        userView.userInteractionEnabled = YES;
        [userView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewAction:)]];
        userView.tag = i;
        [self.iconsScrollView addSubview:userView];
    }
}
// 变圆角
- (void)maskViewToBounds:(UIView *)view
{
    view.layer.cornerRadius = view.GHZ_height * 0.5;
    view.layer.masksToBounds = YES;
}
#pragma mark - 懒加载orSetGet方法
- (NSMutableArray *)userArray
{
    if (!_userArray) {
        NSArray *array = [NSArray arrayWithContentsOfFile:userPlist];
        _userArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            GHZHotModel *model = [[GHZHotModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_userArray addObject:model];
        }
    }
    return _userArray;
}
- (void)setLiveNewModel:(GHZLiveNewModel *)liveNewModel
{
    _liveNewModel = liveNewModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:liveNewModel.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconImageViewAction:)];
    [self.iconImageView addGestureRecognizer:tap];
    self.nameLabel.text = liveNewModel.myname;
    self.personsLabel.text = [NSString stringWithFormat:@"%ld人", liveNewModel.allnum];
    [self.countButton setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u", 1993045,  124593] forState:UIControlStateNormal];
}
#pragma mark - 按钮点击事件
//按钮点击事件
- (IBAction)closeOrOpenAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.closeOrOpenAction) {
        self.closeOrOpenAction(sender);
    }
}

- (IBAction)countAction:(UIButton *)sender
{
    if (self.countAction) {
        self.countAction(sender);
    }
}
- (void)iconImageViewAction:(UITapGestureRecognizer *)tap
{
    if (tap.view == self.iconImageView) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : self.liveNewModel}];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : self.userArray[tap.view.tag]}];
    }
    
}

@end
