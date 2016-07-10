//
//  GHZShowPlaceHolderView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/10.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
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

@end


@implementation GHZShowPlaceHolderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.startShowingButton.layer.cornerRadius = self.startShowingButton.GHZ_height * 0.5;
    self.startShowingButton.layer.masksToBounds = YES;
    self.startShowingButton.layer.borderColor = [UIColor colorWithRed:54 green:214 blue:255 alpha:0.7].CGColor;
    self.startShowingButton.layer.borderWidth = 2;
}

/**  私密按钮 */
- (IBAction)secretAction:(id)sender
{
    
}
/**  添加话题按钮 */
- (IBAction)topicAction:(id)sender
{
    
}
/**  直播按钮 */
- (IBAction)startShowingAction:(id)sender
{
    
}
/**  分享按钮 */
- (IBAction)shareAction:(UIButton *)sender
{
    
}
/** 位置按钮 */
- (IBAction)locationAction:(id)sender
{
    
}
/**  关闭按钮 */
- (IBAction)closeAction:(id)sender
{
    if (self.closeAction) {
        self.closeAction(sender);
    }
}

@end
