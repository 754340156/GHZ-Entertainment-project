//
//  GHZProfileHeaderView.m
//  GHZxiangmuB
//
//  Created by    on 16/7/13.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZProfileHeaderView.h"
#import "GHZUserSetting.h"
#import <EMSDK.h>

@interface GHZProfileHeaderView ()
/**  昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
/**  头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end


@implementation GHZProfileHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = self.iconImageView.GHZ_width * 0.5;
    self.nickNameLabel.text = [GHZUserSetting shareInstance].nickName;
    
}

/**  去聊天按钮 */
- (IBAction)chatAction:(UIButton *)sender
{
    if (self.chatAction) {
        self.chatAction(sender);
    }
}

@end
