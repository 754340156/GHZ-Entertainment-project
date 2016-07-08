//
//  GHZLivingTopView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLivingTopView.h"

@interface GHZLivingTopView ()
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personsLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeOrOpenButton;
@property (weak, nonatomic) IBOutlet UIScrollView *iconsScrollView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end


@implementation GHZLivingTopView

- (void)awakeFromNib
{
    [self maskViewToBounds:self.countButton];
    [self maskViewToBounds:self.closeOrOpenButton];
    [self maskViewToBounds:self.iconImageView];
    [self maskViewToBounds:self.backView];
    [self setScrollView];
}

- (void)setScrollView
{
//    self.iconsScrollView.contentSize =
}
// 变圆角
- (void)maskViewToBounds:(UIView *)view
{
    view.layer.cornerRadius = view.GHZ_height * 0.5;
    view.layer.masksToBounds = YES;
}
#pragma mark - 按钮点击事件
- (IBAction)closeOrOpenAction:(UIButton *)sender
{
    
}

- (IBAction)countAction:(UIButton *)sender
{
    
}


@end
