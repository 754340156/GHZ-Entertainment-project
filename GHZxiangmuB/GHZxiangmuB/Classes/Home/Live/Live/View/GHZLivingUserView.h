//
//  GHZLivingUserView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZHotModel,GHZLiveNewModel;
@interface GHZLivingUserView : UIView
/**  最热模块模型 */
@property (nonatomic,strong) GHZHotModel *hotModel;
/**  最新模块模型 */
@property (nonatomic,strong) GHZLiveNewModel *liveNewModel;
/**  点击了关闭的按钮 */
@property (nonatomic,copy) void(^closeAction)(UIButton *closeButton);

@end
