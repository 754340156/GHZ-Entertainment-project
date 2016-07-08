//
//  GHZBottomView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LiveBottomButtonType) {
    LiveBottomButtonTypePublicTalk = 101,
    LiveBottomButtonTypePrivateTalk,
    LiveBottomButtonTypeSendgift,
    LiveBottomButtonTypeRank,
    LiveBottomButtonTypeShare,
    LiveBottomButtonTypeClose
};

@interface GHZBottomView : UIView
/** 点击了哪个按钮 */
@property (nonatomic,copy)void (^bottomClickAction)(LiveBottomButtonType type);
@end