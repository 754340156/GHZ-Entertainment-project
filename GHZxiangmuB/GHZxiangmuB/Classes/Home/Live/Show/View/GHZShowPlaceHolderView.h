//
//  GHZShowPlaceHolderView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/10.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZShowPlaceHolderView : UIView
/**  直播按钮 */
@property (nonatomic,copy) void (^startShowingAction)(UIButton *);
/** 关闭按钮 */
@property (nonatomic,copy) void (^closeAction)(UIButton *);
@end
