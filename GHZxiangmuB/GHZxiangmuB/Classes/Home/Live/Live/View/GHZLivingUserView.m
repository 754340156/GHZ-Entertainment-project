//
//  GHZLivingUserView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLivingUserView.h"
#import "GHZHotModel.h"
#import "GHZLiveNewModel.h"
#import <SDWebImage/SDWebImageDownloader.h>
#import "UIImage+Extension.h"
@interface GHZLivingUserView ()
/**  头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/**  主播名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**  用户IDX */
@property (weak, nonatomic) IBOutlet UILabel *userIDXLabel;
/**  个性签名 */
@property (weak, nonatomic) IBOutlet UILabel *signaturesLabel;
/**  关注 */
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;
/**  粉丝 */
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
/**  消费 */
@property (weak, nonatomic) IBOutlet UILabel *saleLabel;
/**  猫粮 */
@property (weak, nonatomic) IBOutlet UILabel *catfoodLable;
/**  关注按钮 */
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;

@end


@implementation GHZLivingUserView

- (void)awakeFromNib
{
    [super awakeFromNib];
    //关注按钮变圆角
    [self maskViewToBounds:self.attentionButton CornerRadius:3];
    [self maskViewToBounds:self CornerRadius:5];
}
- (void)setLiveNewModel:(GHZLiveNewModel *)liveNewModel
{
    _liveNewModel = liveNewModel;
    self.nameLabel.text = liveNewModel.myname;
    self.signaturesLabel.text = liveNewModel.signatures;
    self.userIDXLabel.text = [NSString stringWithFormat:@"IDX:%ld",(long)liveNewModel.useridx];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:liveNewModel.smallpic] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconImageView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:iconBoundWidth];
        });
    }];
     //富文本
    [self addAttributeWithView:self.attentionLabel Color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11] baseString:@"关注" otherString:@"500"];
    [self addAttributeWithView:self.fansLabel Color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11] baseString:@"粉丝" otherString:@"500"];
    [self addAttributeWithView:self.saleLabel Color:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:0.6] font:[UIFont systemFontOfSize:11] baseString:@"消费" otherString:@"113万"];
    [self addAttributeWithView:self.catfoodLable Color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11] baseString:@"猫粮" otherString:@"112万"];
}

- (void)setHotModel:(GHZHotModel *)hotModel
{
    _hotModel = hotModel;
    self.nameLabel.text = hotModel.nickname;
//    self.signaturesLabel.text = hotModel.signatures;
    self.userIDXLabel.text = [NSString stringWithFormat:@"IDX:%ld",(long)hotModel.useridx];
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:hotModel.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconImageView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:iconBoundWidth];
        });
    }];
    //富文本
    [self addAttributeWithView:self.attentionLabel Color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11] baseString:@"关注" otherString:@"500"];
    [self addAttributeWithView:self.fansLabel Color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11] baseString:@"粉丝" otherString:@"500"];
    [self addAttributeWithView:self.saleLabel Color:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:0.6] font:[UIFont systemFontOfSize:11] baseString:@"消费" otherString:@"113万"];
    [self addAttributeWithView:self.catfoodLable Color:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11] baseString:@"猫粮" otherString:@"112万"];
}

#pragma mark - 按钮的点击事件
//举报
- (IBAction)reportAction:(UIButton *)sender
{
    
}
//关闭
- (IBAction)closeAction:(UIButton *)sender
{
    if (self.closeAction) {
        self.closeAction(sender);
    }
}
//关注
- (IBAction)attentionAction:(UIButton *)sender
{
    
}
//送礼
- (IBAction)presentAction:(UIButton *)sender
{
    
}
//私聊
- (IBAction)privateChatAction:(UIButton *)sender
{
    
}
//邀播
- (IBAction)inviteAction:(UIButton *)sender
{
    
}
//踢出
- (IBAction)kickoutAction:(UIButton *)sender
{
    
}
#pragma mark - 工具方法
//富文本方法
- (void)addAttributeWithView:(UILabel *)view Color:(UIColor *)color font:(UIFont *)font baseString:(NSString *)baseString otherString:(NSString *)otherString
{
    NSString *count = [NSString stringWithFormat:@"%@:%@", baseString,otherString];
    NSRange range = [count rangeOfString:[NSString stringWithFormat:@"%@",baseString]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:count];
    [attr addAttribute:NSFontAttributeName value:font range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    view.attributedText = attr;
}

// 变圆角
- (void)maskViewToBounds:(UIView *)view CornerRadius:(CGFloat)cornerRadius
{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}

@end
