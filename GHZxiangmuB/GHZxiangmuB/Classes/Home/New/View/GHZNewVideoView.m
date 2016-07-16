//
//  GHZNewVideoView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewVideoView.h"
#import "GHZTopicModel.h"
#import "UIImageView+WebCache.h"
#import "GHZShowpirtureController.h"
#import "GHZVideoPlayerController.h"
@interface GHZNewVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong) GHZVideoPlayerController *videoController;
@end

@implementation GHZNewVideoView

+(instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
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
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage]];
    
    self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放",  model.playcount];
    //时长
    NSInteger f = model.videotime/60;
    NSInteger m = model.videotime%60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%.02ld:%.02ld",f,m];
}
- (IBAction)VideoButton:(UIButton *)sender {
    [self playVideoWithURL:[NSURL URLWithString:self.model.videouri]];
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
