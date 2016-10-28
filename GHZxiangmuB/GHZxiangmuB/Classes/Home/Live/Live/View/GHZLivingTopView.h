//
//  GHZLivingTopView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/8.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZHotModel,GHZLiveNewModel;


@interface GHZLivingTopView : UIView
/**  最热模块模型 */
@property (nonatomic,strong) GHZHotModel *hotModel;
/**  最新模块模型 */
@property (nonatomic,strong) GHZLiveNewModel *liveNewModel;
/**  点击开启关闭开关 */
@property (nonatomic,copy) void (^closeOrOpenAction)(UIButton *closeOrOpenButton);
/** 点击直播人数开关 */
@property (nonatomic,copy) void (^countAction)(UIButton *countButton);
@end
