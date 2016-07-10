//
//  GHZHotCollectionViewCell.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZHotCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GHZHotModel.h"
@interface GHZHotCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UIImageView *isNewImageView;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@end


@implementation GHZHotCollectionViewCell

- (void)setModel:(GHZHotModel *)model
{
     __weak typeof(self)weakself = self;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType != SDImageCacheTypeMemory ) {
            weakself.backImageView.transform = CGAffineTransformMakeScale(0.4, 0.4);
            [UIView animateWithDuration:0.4 animations:^{
                weakself.backImageView.transform = CGAffineTransformIdentity;
            }];
        }
    }];
    self.nameLabel.text = model.nickname;
    [self setLevelWithIndex:model.starlevel];
    if (!model.position.length) {
        model.position = @"来自火星";
    }
    [self.locationButton setTitle:model.position forState:UIControlStateNormal];
    self.isNewImageView.hidden = !model.new;
}
- (void)setLevelWithIndex:(NSInteger )index
{
    if (index == 0) {
        self.levelImageView.hidden = YES;
    }else
    {
        self.levelImageView.hidden = NO;
        self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"girl_star%ld_40x19",(long)index]];
    }
}
@end
