//
//  GHZShowingView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZShowLivingView.h"

@interface GHZShowLivingView ()
/**  美颜按钮 */
@property (weak, nonatomic) IBOutlet UIButton *beautifulButton;


@end


@implementation GHZShowLivingView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.beautifulButton.layer.cornerRadius = self.beautifulButton.GHZ_height * 0.5;
    self.beautifulButton.layer.masksToBounds = YES;
}

/**  智能美颜按钮 */
- (IBAction)beautifulAction:(UIButton *)sender
{
    if (self.beautifulAction) {
        self.beautifulAction(sender);
    }
}
/**  切换前后摄像头 */
- (IBAction)cameraAction:(UIButton *)sender
{
    if (self.cameraAction) {
        self.cameraAction(sender);
    }
}
/**  关闭直播按钮 */
- (IBAction)closeAction:(UIButton *)sender
{
    if (self.closeAction) {
        self.closeAction(sender);
    }
}

@end
