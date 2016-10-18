//
//  GHZSeletedChatView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/11.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, HomeType) {
    HomeTypeConversation, // 会话
    HomeTypeFriend, // 好友
    HomeTypeAssist // 辅助
};
@interface GHZSeletedChatView : UIView
/** 选中了 */
@property(nonatomic, copy)void (^selectedBlock)(HomeType type);
/** 下划线 */
@property (nonatomic, weak, readonly)UIView *underLine;
/** 设置滑动选中的按钮 */
@property(nonatomic, assign) HomeType selectedType;
@end
