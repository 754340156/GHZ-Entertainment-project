//
//  GHZNewMusicController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewMusicController.h"
#import "NSString+GHZTime.h"
@interface GHZNewMusicController ()
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *resttime;
@property (weak, nonatomic) IBOutlet UISlider *progress;
@property (weak, nonatomic) IBOutlet UILabel *playtime;
@property (nonatomic,strong)MPMoviePlayerController *player;
@property (nonatomic,strong)NSTimer *progressTimer;

-(IBAction)startSlide;
-(IBAction)sliderValueChange;
-(IBAction)endSlider;
@end

@implementation GHZNewMusicController
static GHZNewMusicController *tool = nil;
+(instancetype)sharinit{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[GHZNewMusicController alloc] initWithNibName:@"GHZNewMusicController" bundle:nil];
    });
    return tool;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progress setThumbImage:[UIImage imageNamed:@"kr-video-player-point"] forState:(UIControlStateNormal)];
    [self startPlayingMusic];
    self.playtime.text = [NSString stringWithTime:self.totalTime];
    [self.progress addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTap:)]];
    _player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.url]];
    [self.player play];
}
//开始播放音乐
- (void)startPlayingMusic {
    [self removeProgressTimer];
    [self addProgressTimer];
    
}
//添加定时器
- (void)addProgressTimer
{
    [self updateProgressInfo];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

-(void)updateProgressInfo{
    //设置当前的播放时间
    self.resttime.text = [NSString stringWithTime:self.player.currentPlaybackTime];
    
    self.progress.value = self.player.currentPlaybackTime / self.player.duration;
}
-(IBAction)startSlide{
    [self removeProgressTimer];
}
-(IBAction)sliderValueChange{
    
    //设置当前label播放时间
    self.resttime.text = [NSString stringWithTime:self.player.duration * self.progress.value];
    
}
-(IBAction)endSlider{
    //设置播放时间
     self.player.currentPlaybackTime = self.progress.value *self.player.duration;
    //添加定时器
    [self addProgressTimer];
}
-(void)sliderTap:(UITapGestureRecognizer *)tap{
    //获取点寄的位置
    CGPoint point = [tap locationInView:tap.view];
    
    //获取点击的在slider长度中占据的比例
    CGFloat ratio = point.x / self.progress.bounds.size.width;
    
    //改编歌曲播放时间
    self.player.currentPlaybackTime = ratio * self.player.duration;
    
    //更新进度信息
    [self updateProgressInfo];
}


- (IBAction)Playing:(id)sender {
    self.playBtn.selected = !self.playBtn.selected;
    if (self.playBtn.selected) {
        [self.player pause];
        [self removeProgressTimer];
    }else{
        [self.player play];
        [self addProgressTimer];
    }
}

-(void)removeProgressTimer{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}
-(void)dismiss{
    [self removeProgressTimer];
    [self.player stop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end