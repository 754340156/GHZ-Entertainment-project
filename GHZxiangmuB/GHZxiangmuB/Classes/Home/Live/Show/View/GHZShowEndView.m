//
//  GHZShowEndView.m
//  GHZxiangmuB
//
//  Created by    on 16/7/11.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZShowEndView.h"

@interface GHZShowEndView ()
/**  观众人数 */
@property (weak, nonatomic) IBOutlet UILabel *audiencesLabel;
/**  映票数量 */
@property (weak, nonatomic) IBOutlet UILabel *picketsLabel;

/**  返回首页按钮 */
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end



@implementation GHZShowEndView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = [UIScreen mainScreen].bounds;
    [self layoutIfNeeded];
    self.backButton.layer.cornerRadius = self.backButton.GHZ_height * 0.5;
    self.backButton.layer.masksToBounds = YES;
    self.backButton.layer.borderColor = [UIColor colorWithRed:54/255.0 green:214/255.0 blue:255/255.0 alpha:0.7].CGColor;
    self.backButton.layer.borderWidth = 2;
    [self addAttributeWithView:self.audiencesLabel Color:[UIColor colorWithRed:54/255.0 green:214/255.0 blue:255/255.0 alpha:0.7] Range:NSMakeRange(0, 1)];
    [self addAttributeWithView:self.picketsLabel Color:KeyColor Range:NSMakeRange(2, 1)];
}
/**  返回按钮 */
- (IBAction)backAction:(UIButton *)sender
{
    if (self.backAction) {
        self.backAction(sender);
    }
}
/**  删除按钮 */
- (IBAction)deleteAction:(UIButton *)sender
{
    
    if (self.deleteAction) {
        self.deleteAction(sender);
    }
}
//富文本方法
- (void)addAttributeWithView:(UILabel *)view Color:(UIColor *)color Range:(NSRange)range
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:view.text];
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    view.attributedText = attr;
}

@end
