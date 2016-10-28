//
//  GHZLivingEndView.m
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZLivingEndView.h"

@interface GHZLivingEndView ()
/**  直播总时长 */
@property (weak, nonatomic) IBOutlet UILabel *totalTimerLabel;
/**  直播总人数 */
@property (weak, nonatomic) IBOutlet UILabel *totalPersonsLable;
/**  关注按钮 */
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
/**  查看其它主播按钮 */
@property (weak, nonatomic) IBOutlet UIButton *lookOtherButton;
/**  退出直播按钮 */
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@end


@implementation GHZLivingEndView


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self maskRadius:self.attentionButton];
    [self maskRadius:self.lookOtherButton];
    [self maskRadius:self.exitButton];
}

- (IBAction)attentionAction:(UIButton *)sender
{
    [sender setTitle:@"关注成功" forState:UIControlStateNormal];

}
- (IBAction)lookOtherAction:(UIButton *)sender
{
    if (self.lookOtherAction) {
        self.lookOtherAction(sender);
    }
}

- (IBAction)extiAction:(UIButton *)sender
{
    if (self.exitAction) {
        self.exitAction(sender);
    }
}
//切圆角
- (void)maskRadius:(UIButton *)sender
{
    sender.layer.cornerRadius = sender.GHZ_height * 0.5;
    sender.layer.masksToBounds = YES;
    if (sender != self.attentionButton) {
        sender.layer.borderWidth = iconBoundWidth;
        sender.layer.borderColor = KeyColor.CGColor;
    }
}
@end
