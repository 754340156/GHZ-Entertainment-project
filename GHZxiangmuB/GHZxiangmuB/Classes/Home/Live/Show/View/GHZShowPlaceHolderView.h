//
//  GHZShowPlaceHolderView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/10.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZShowPlaceHolderView : UIView


/** 关闭按钮 */
@property (nonatomic,copy) void (^closeAction)(UIButton *);
@end
