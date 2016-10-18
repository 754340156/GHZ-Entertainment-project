//
//  GHZTopicVoiceView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/13.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopic;
@interface GHZTopicVoiceView : UIView

+ (instancetype)voiceView;
/**帖子数据*/
@property(nonatomic, strong)  GHZTopic *model;
- (void)reset;
@end
