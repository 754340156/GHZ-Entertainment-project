//
//  GHZProfileHeaderView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZProfileHeaderView.h"


@interface GHZProfileHeaderView ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end


@implementation GHZProfileHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = self.iconImageView.GHZ_width * 0.5;
}

/**  去聊天按钮 */
- (IBAction)chatAction:(UIButton *)sender
{
    if (self.chatAction) {
        self.chatAction(sender);
    }
}

@end
