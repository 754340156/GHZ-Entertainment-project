//
//  GHZLivingEndView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZLivingEndView : UIView
/**  查看其他主播的点击事件 */
@property (nonatomic,copy) void(^lookOtherAction)(UIButton *lookOtherButton);
/**  退出直播的点击事件 */
@property (nonatomic,copy) void(^exitAction)(UIButton *exitButton);
@end
