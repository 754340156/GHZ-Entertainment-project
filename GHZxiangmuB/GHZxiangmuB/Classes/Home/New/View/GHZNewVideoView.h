//
//  GHZNewVideoView.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopicModel;
#import "XLVideoPlayer.h"




@protocol GHZNewVideoViewDelegate <NSObject>
- (void)clickWithbutton:(UIButton*)btn;

@end
@interface GHZNewVideoView : UIView




+(instancetype)videoView;
@property (nonatomic,strong)GHZTopicModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong)XLVideoPlayer *player;



@property ( nonatomic,weak)id <GHZNewVideoViewDelegate>delegate;
//@property (nonatomic,copy)void(^click)(UIButton *);
@end
