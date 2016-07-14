//
//  GHZNewMusicView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewMusicView.h"
#import "GHZTopicModel.h"
#import "UIImageView+WebCache.h"
#import "GHZShowpirtureController.h"
#import <AVFoundation/AVFoundation.h>
#import "GHZNewMusicController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface GHZNewMusicView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;
@property (weak, nonatomic) IBOutlet UIButton *Playbtn;
@property (nonatomic,strong)NSMutableArray *arr;
@property (nonatomic,strong)GHZNewMusicController *musicPlayer;
@end


@implementation GHZNewMusicView




+(instancetype)MusicView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;

}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowImage)]];
}
-(void)ShowImage{
    GHZShowpirtureController *vc = [[GHZShowpirtureController alloc] init];
    vc.model = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

-(void)setModel:(GHZTopicModel *)model{
    _model =  model;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage]];
    //播放资源
    self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放",model.playcount];
//    NSInteger str = [model.voicetime intValue];
    NSInteger f = model.voicetime/60;
    NSInteger m = model.voicetime%60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%.02ld:%.02ld",f,m];
}
- (IBAction)Playing:(id)sender {
    self.Playbtn.hidden = YES;
    self.musicPlayer = [GHZNewMusicController sharinit];
    self.musicPlayer.url = self.model.voiceuri;
    self.musicPlayer.totalTime = self.model.voicetime;
    NSLog(@"%ld",(long)self.model.voicetime);
    self.musicPlayer.view.GHZ_width = self.imageView.GHZ_width;
    self.musicPlayer.view.GHZ_y = self.imageView.GHZ_height - self.musicPlayer.view.GHZ_height;
    [self addSubview:self.musicPlayer.view];
}
-(void)reset{
    [self.musicPlayer dismiss];
    [self.musicPlayer.view removeFromSuperview];
    self.musicPlayer = nil;
    self.Playbtn.hidden = NO;
}


@end
