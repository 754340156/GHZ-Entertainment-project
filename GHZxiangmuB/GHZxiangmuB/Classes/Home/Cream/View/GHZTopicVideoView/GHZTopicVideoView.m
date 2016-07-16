//
//  GHZTopicVideoView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTopicVideoView.h"
#import "GHZTopic.h"
#import <UIImageView+WebCache.h>
#import "GHZShowPictureViewController.h"
#import "GHZVideoPlayerController.h"
@interface GHZTopicVideoView ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *playcountLabel;
@property (strong, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (nonatomic, strong) GHZVideoPlayerController *videoController;
@end


@implementation GHZTopicVideoView

+(instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture{
    GHZShowPictureViewController *showPicture = [[GHZShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil ];
    
    
}
- (void)setTopic:(GHZTopic *)topic{
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    //播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
- (IBAction)VideoButton:(UIButton *)sender {
    [self playVideoWithURL:[NSURL URLWithString:self.topic.videouri]];
    [self addSubview:self.videoController.view];
}
- (void)playVideoWithURL:(NSURL *)url {
    if (!self.videoController) {
        self.videoController = [[GHZVideoPlayerController alloc] initWithFrame:self.imageView.bounds];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
    }
    self.videoController.contentURL = url;
}

//停止视频的播放
- (void)reset {
    [self.videoController dismiss];
    self.videoController = nil;
}
@end
