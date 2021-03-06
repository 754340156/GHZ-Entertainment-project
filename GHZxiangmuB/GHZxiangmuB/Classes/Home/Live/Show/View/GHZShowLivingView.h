//
//  GHZShowingView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/11.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZShowLivingView : UIView

/**  智能美颜 */
@property (nonatomic,copy) void (^beautifulAction)(UIButton *);
/**  关闭直播 */
@property (nonatomic,copy) void (^closeAction)(UIButton *);
/**  切换摄像头 */
@property (nonatomic,copy) void (^cameraAction)(UIButton *);
@end
