//
//  GHZTopicVoiceView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTopicVoiceView.h"
#import "GHZTopic.h"
#import <UIImageView+WebCache.h>
#import "GHZShowPictureViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface GHZTopicVoiceView ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *playCountLabel;

@property (nonatomic, strong) AVAudioPlayer *player;
@end



@implementation GHZTopicVoiceView


+ (instancetype)voiceView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}


- (void)awakeFromNib{
    
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
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];

}
- (IBAction)voiceClick:(id)sender {
    
    NSURL *url = [NSURL URLWithString:_topic.voiceuri];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    //[self.player prepareToPlay];
    
    [ self.player play];
    
    
}

@end
