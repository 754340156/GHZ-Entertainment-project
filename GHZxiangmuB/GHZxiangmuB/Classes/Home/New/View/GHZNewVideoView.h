//
//  GHZNewVideoView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/12.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopicModel,XLVideoPlayer;

@interface GHZNewVideoView : UIView

+(instancetype)videoView;
@property (nonatomic,strong)GHZTopicModel *model;
- (void)reset;
@end
