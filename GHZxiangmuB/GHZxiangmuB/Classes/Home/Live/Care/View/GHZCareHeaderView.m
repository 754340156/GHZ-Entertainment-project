//
//  GHZCareHeaderView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/10.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCareHeaderView.h"

@interface GHZCareHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *lookUserbutton;

@end



@implementation GHZCareHeaderView

- (IBAction)lookUserAction:(UIButton *)sender
{
    if (self.lookUserAction) {
        self.lookUserAction(sender);
    }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.lookUserbutton.layer.cornerRadius = self.lookUserbutton.GHZ_height * 0.5;
    self.lookUserbutton.layer.masksToBounds = YES;
    self.lookUserbutton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.lookUserbutton.layer.borderWidth = 2;
}

@end
