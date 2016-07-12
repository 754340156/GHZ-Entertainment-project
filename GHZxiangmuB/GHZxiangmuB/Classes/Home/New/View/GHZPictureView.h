//
//  GHZPictureView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
// 图片中间那片数据

#import <UIKit/UIKit.h>
@class GHZTopicModel;
@interface GHZPictureView : UIView
+(instancetype)pictureView;
/** 段子model*/
@property (nonatomic,strong)GHZTopicModel *model;
@end
