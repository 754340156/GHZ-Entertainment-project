//
//  GHZTopicVideoView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopic;
@interface GHZTopicVideoView : UIView

+ (instancetype)videoView;

/**帖子数据*/
@property(nonatomic, strong)  GHZTopic *topic;
@end
