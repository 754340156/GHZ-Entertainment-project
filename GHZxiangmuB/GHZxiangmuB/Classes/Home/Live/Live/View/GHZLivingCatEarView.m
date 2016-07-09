//
//  GHZLivingCatEarView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLivingCatEarView.h"
#import "GHZLiveNewModel.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface GHZLivingCatEarView ()
/**  背景View */
@property (weak, nonatomic) IBOutlet UIView *backView;
/**  上面的翅膀 */
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
/**  直播的播放器 */
@property (nonatomic,strong) IJKFFMoviePlayerController *moviePlayer;
@end


@implementation GHZLivingCatEarView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backView.layer.cornerRadius = self.backView.GHZ_height * 0.5;
    self.backView.layer.masksToBounds = YES;
}

- (void)setModel:(GHZLiveNewModel *)model
{
    [self setMoviePlayerWithUrl:model.flv];
}

- (void)setMoviePlayerWithUrl:(NSString *)url
{
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        [options setPlayerOptionValue:@"1" forKey:@"an"];
        // 开启硬解码
        [options setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
        self.moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:url withOptions:options];
    self.moviePlayer.view.frame = self.backView.bounds;
    // 填充fill
    self.moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放
    self.moviePlayer.shouldAutoplay = YES;
    [self.backView addSubview:self.moviePlayer.view];
    [self.moviePlayer prepareToPlay];
}
- (void)removeFromSuperview
{
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
    }
    [super removeFromSuperview];
}
@end
