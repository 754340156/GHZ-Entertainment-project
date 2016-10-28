//
//  GHZCommentTableViewCell.m
//  GHZxiangmuB
//
//  Created by    on 16/7/17.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"
#import "GHZCommentModel.h"
@interface GHZCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gender;
@property (weak, nonatomic) IBOutlet UILabel *like;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end


@implementation GHZCommentTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
//使cell一定成为第一响应者
- (BOOL)canBecomeFirstResponder {
    return YES;
}
//支持的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}
- (void)setModel:(GHZCommentModel *)model
{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.user.profile_image] placeholderImage:[UIImage circleImage:[UIImage imageNamed:@"defaultUserIcon"] borderColor:nil borderWidth:0] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImageView.image = image ? [UIImage circleImage:image borderColor:nil borderWidth:0] : [UIImage circleImage:[UIImage imageNamed:@"defaultUserIcon"] borderColor:nil borderWidth:0];
    }];
    if (model.voiceuri.length) {
        self.playBtn.hidden = NO;
        [self.playBtn setTitle:[NSString stringWithFormat:@"%ld''", model.voicetime] forState:UIControlStateNormal];
    } else {
        self.playBtn.hidden = YES;
    }
    self.content.text = model.content;
    self.nameLabel.text = model.user.username;
    self.like.text = [NSString stringWithFormat:@"%ld", (long)model.like_count];
    CGFloat commentH = [self.content.text boundingRectWithSize:CGSizeMake(204, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
    
    model.cellHeight = 50 + commentH;
}
@end
