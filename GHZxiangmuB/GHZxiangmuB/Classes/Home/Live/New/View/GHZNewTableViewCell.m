//
//  GHZNewTableViewCell.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GHZLiveNewModel.h"
#import "UIImage+Extension.h"
@interface GHZNewTableViewCell ()
/**  大图 */
@property (weak, nonatomic) IBOutlet UIImageView *bigPicImageView;
/**  头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/**  位置 */
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
/**  主播名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**  主播等级 */
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
/**  直播人数 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation GHZNewTableViewCell


- (void)setModel:(GHZLiveNewModel *)model
{
    [self.bigPicImageView  sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage  circleImage:image borderColor:[UIColor redColor] borderWidth:2];
        self.iconImageView.image = image;
    }];
    if (!model.gps.length) {
        model.gps = @"喵星";
    }
    [self.locationButton setTitle:model.gps forState:UIControlStateNormal];
    self.nameLabel.text = model.myname;
    
    [self setLevelWithIndex:model.starlevel];
    // 设置当前观众数量
    NSString *count = [NSString stringWithFormat:@"%ld人在看", model.allnum];
    NSRange range = [count rangeOfString:[NSString stringWithFormat:@"%ld", model.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:count];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:KeyColor range:range];
    self.countLabel.attributedText = attr;
}

- (void)setLevelWithIndex:(NSInteger )index
{
    if (index == 0) {
        self.levelImageView.hidden = YES;
    }else
    {
        self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19",index]];
    }
}
@end
