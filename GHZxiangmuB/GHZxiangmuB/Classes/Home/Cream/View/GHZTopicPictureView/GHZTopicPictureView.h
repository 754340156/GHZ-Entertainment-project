//
//  GHZTopicPictureView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//  图片帖子中的的内容

#import <UIKit/UIKit.h>
@class GHZTopic;
@interface GHZTopicPictureView : UIView

+ (instancetype)pictureView;

/**帖子数据*/
@property(nonatomic, strong)  GHZTopic *topic;

@end