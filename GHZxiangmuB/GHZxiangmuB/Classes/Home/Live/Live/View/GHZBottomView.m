//
//  GHZBottomView.m
//  GHZxiangmuB
//
//  Created by    on 16/7/8.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZBottomView.h"




@implementation GHZBottomView

- (IBAction)Action:(UIButton *)sender
{
    if (self.bottomClickAction) {
        self.bottomClickAction(sender.tag);
    }
}

@end
