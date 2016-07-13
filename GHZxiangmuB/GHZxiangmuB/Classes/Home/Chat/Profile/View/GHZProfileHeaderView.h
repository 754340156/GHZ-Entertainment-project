//
//  GHZProfileHeaderView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZProfileHeaderView : UIView


/**  去聊天界面 */
@property (nonatomic,copy) void (^chatAction)(UIButton *);
@end
