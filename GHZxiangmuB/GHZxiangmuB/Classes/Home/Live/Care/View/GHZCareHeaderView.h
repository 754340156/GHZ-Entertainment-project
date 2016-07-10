//
//  GHZCareHeaderView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/10.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZCareHeaderView : UIView


/**  点击了去看主播按钮 */
@property (nonatomic,copy) void (^lookUserAction)(UIButton *);
@end
