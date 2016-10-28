//
//  GHZLivingCollectionViewCell.h
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZLiveNewModel;
@interface GHZLivingCollectionViewCell : UICollectionViewCell
/** 直播 */
@property (nonatomic, strong) GHZLiveNewModel *live;
/** 相关的直播或者主播 */
@property (nonatomic, strong) GHZLiveNewModel *relateLive;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *fatherVC;
/** 点击关联主播 */
@property (nonatomic, copy) void (^clickRelatedLive)();
@end
