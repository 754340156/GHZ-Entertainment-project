//
//  GHZShowPlaceHolderView.m
//  GHZxiangmuB
//
//  Created by    on 16/7/10.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZShowPlaceHolderView.h"

@interface GHZShowPlaceHolderView ()
/**  位置按钮 */
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
/**  关闭按钮 */
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
/**  直播标题 */
@property (weak, nonatomic) IBOutlet UITextView *showNameTextView;
/**  直播按钮 */
@property (weak, nonatomic) IBOutlet UIButton *startShowingButton;
/**  分享按钮 */
@property (weak, nonatomic) IBOutlet UIButton *share1;
@property (weak, nonatomic) IBOutlet UIButton *share2;
@property (weak, nonatomic) IBOutlet UIButton *share3;
@property (weak, nonatomic) IBOutlet UIButton *share4;
@property (weak, nonatomic) IBOutlet UIButton *share5;
@end


@implementation GHZShowPlaceHolderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = [UIScreen mainScreen].bounds;
    [self layoutIfNeeded];
    self.startShowingButton.layer.cornerRadius = self.startShowingButton.GHZ_height * 0.5;
    self.startShowingButton.layer.masksToBounds = YES;
    self.startShowingButton.layer.borderColor = [UIColor colorWithRed:54/255.0 green:214/255.0 blue:255/255.0 alpha:0.7].CGColor;
    self.startShowingButton.layer.borderWidth = 2;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self.showNameTextView becomeFirstResponder];
    });
  
}

/**  添加话题按钮 */
- (IBAction)topicAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
/**  直播按钮 */
- (IBAction)startShowingAction:(UIButton *)sender
{
    [self.showNameTextView resignFirstResponder];
    sender.selected = !sender.selected;
    if (self.startShowingAction) {
        self.startShowingAction(sender);
    }
}
/**  分享按钮 */
- (IBAction)shareAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
/** 位置按钮 */
- (IBAction)locationAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
/**  关闭按钮 */
- (IBAction)closeAction:(UIButton *)sender
{
    [self.showNameTextView resignFirstResponder];
    if (self.closeAction) {
        self.closeAction(sender);
    }
}
/**  私密按钮 */
- (IBAction)secretAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.25 animations:^{
            self.share1.transform = CGAffineTransformMakeScale(0, 0);
            self.share2.transform = CGAffineTransformMakeScale(0, 0);
            self.share3.transform = CGAffineTransformMakeScale(0, 0);
            self.share4.transform = CGAffineTransformMakeScale(0, 0);
            self.share5.transform = CGAffineTransformMakeScale(0, 0);
        } completion:^(BOOL finished) {
            self.share1.hidden = YES;
            self.share2.hidden = YES;
            self.share3.hidden = YES;
            self.share4.hidden = YES;
            self.share5.hidden = YES;
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.share1.transform = CGAffineTransformIdentity;
            self.share2.transform = CGAffineTransformIdentity;
            self.share3.transform = CGAffineTransformIdentity;
            self.share4.transform = CGAffineTransformIdentity;
            self.share5.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.share1.hidden = NO;
            self.share2.hidden = NO;
            self.share3.hidden = NO;
            self.share4.hidden = NO;
            self.share5.hidden = NO;
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.showNameTextView resignFirstResponder];
}
@end
