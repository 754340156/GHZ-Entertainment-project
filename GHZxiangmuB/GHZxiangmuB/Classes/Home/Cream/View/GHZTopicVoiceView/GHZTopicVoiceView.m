//
//  GHZTopicVoiceView.m
//  GHZxiangmuB
//
//  Created by    on 16/7/13.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZTopicVoiceView.h"
#import "GHZTopic.h"
#import <UIImageView+WebCache.h>
#import "GHZShowPictureViewController.h"
#import "GHZNewMusicController.h"
@interface GHZTopicVoiceView ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *Playbtn;
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)GHZNewMusicController *musicPlayer;
@end



@implementation GHZTopicVoiceView


+(instancetype)voiceView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}


- (void)showPicture{
    GHZShowPictureViewController *showPicture = [[GHZShowPictureViewController alloc] init];
    showPicture.topic = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil ];
    
    
}

-(void)setModel:(GHZTopic *)model{
    _model =  model;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.large_image]];
    //播放资源
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld播放",(long)model.playcount];
    NSInteger f = model.voicetime/60;
    NSInteger m = model.voicetime%60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%.02ld:%.02ld",(long)f,(long)m];
}
- (IBAction)Playing:(id)sender {
    self.Playbtn.hidden = YES;
    self.musicPlayer = [[GHZNewMusicController alloc] initWithNibName:@"GHZNewMusicController" bundle:nil];
    self.musicPlayer.url = self.model.voiceuri;
    self.musicPlayer.totalTime = self.model.voicetime;
    self.musicPlayer.view.GHZ_width = self.imageView.GHZ_width;
    self.musicPlayer.view.GHZ_y = self.imageView.GHZ_height - self.musicPlayer.view.GHZ_height;
     __weak typeof(self)weakself = self;
    self.musicPlayer.playerFinish = ^()
    {
        weakself.Playbtn.hidden = NO;
    };
    [self addSubview:self.musicPlayer.view];
}
-(void)reset{
    [self.musicPlayer dismiss];
    [self.musicPlayer.view removeFromSuperview];
    self.musicPlayer = nil;
    self.Playbtn.hidden = NO;
}

@end
