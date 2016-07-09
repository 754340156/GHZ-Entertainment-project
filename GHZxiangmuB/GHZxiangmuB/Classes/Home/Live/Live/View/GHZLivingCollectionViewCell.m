//
//  GHZLivingCollectionViewCell.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.




#import "GHZLivingCollectionViewCell.h"
#import "GHZBottomView.h"
#import "GHZLivingTopView.h"
#import "GHZLivingEndView.h"
#import "GHZLivingCatEarView.h"
#import "UIViewController+Extension.h"
#import "UIImage+Extension.h"
#import "GHZLiveNewModel.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import <AFNetworking/AFNetworking.h>
#import <BarrageRenderer/BarrageRenderer.h>
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface GHZLivingCollectionViewCell ()
/**  直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/**  底部工具栏 */
@property (nonatomic,strong)GHZBottomView *bottomView;
/**  顶部工具栏 */
@property (nonatomic,strong) GHZLivingTopView *topView;
/**  直播结束的界面 */
@property (nonatomic,strong) GHZLivingEndView *endView;
/**  画中画直播 */
@property (nonatomic,strong) GHZLivingCatEarView *catEarView;
/**  直播开始前模糊图片 */
@property(nonatomic, weak) UIImageView *placeHolderView;
/**  同一个工会的主播/相关主播 */
@property(nonatomic, weak) UIImageView *otherView;
/**  粒子动画 */
@property(nonatomic, weak) CAEmitterLayer *emitterLayer;
#warning 弹幕没写
/**  弹幕 */
//@property (nonatomic,strong) BarrageRenderer *renderer;
/**  弹幕的定时器 */
@property (nonatomic,strong) NSTimer *timer;
@end


@implementation GHZLivingCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bottomView.hidden = NO;
    }
    return self;
}

- (void)setBottomView
{
    self.bottomView = [GHZBottomView GHZ_viewFromXib];

    [self addSubview:self.bottomView];

    
}
#pragma mark - 懒加载 setOrGet
- (GHZBottomView *)bottomView
{
     __weak typeof(self)weakself = self;
    if (!_bottomView) {
        _bottomView = [GHZBottomView GHZ_viewFromXib];
        _bottomView.frame = CGRectMake(0, GHZScreenHeight - livingBottomHeight, GHZScreenWidth, livingBottomHeight);
        _bottomView.bottomClickAction = ^(LiveBottomButtonType type)
        {
            switch (type) {
                case LiveBottomButtonTypePublicTalk:
                    break;
                case LiveBottomButtonTypePrivateTalk:
                    break;
                case LiveBottomButtonTypeSendgift:
                    break;
                case LiveBottomButtonTypeRank:
                    break;
                case LiveBottomButtonTypeShare:
                    break;
                case LiveBottomButtonTypeClose:
                    [weakself exit];
                    break;
            }
        };
        [self.contentView insertSubview:_bottomView aboveSubview:self.placeHolderView];
    }
    return _bottomView;
}
- (GHZLivingTopView *)topView
{
    if (!_topView) {
        _topView = [GHZLivingTopView GHZ_viewFromXib];
        _topView.frame = CGRectMake(0, 20, GHZScreenWidth, livingTopHeight);
        [self.contentView insertSubview:_topView aboveSubview:self.placeHolderView];
    }
    return _topView;
}
- (GHZLivingEndView *)endView
{
     __weak typeof(self)weakself = self;
    if (!_endView) {
        _endView = [GHZLivingEndView GHZ_viewFromXib];
        _endView.frame = self.bounds;
        [self.contentView addSubview:_endView];
        _endView.lookOtherAction = ^(UIButton *lookOtherButton)
        {
#warning 点击了查看其它主播按钮
        };
        _endView.exitAction = ^(UIButton * exitButton)
        {
            [weakself exit];
        };
        
    }
    return _endView;
}
- (GHZLivingCatEarView *)catEarView
{
    if (!_catEarView) {
        _catEarView = [GHZLivingCatEarView GHZ_viewFromXib];
        [self.moviePlayer.view addSubview:_catEarView];
        [_catEarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCatEarView)]];
        [_catEarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-30);
            make.centerY.equalTo(self.moviePlayer.view);
            make.width.height.equalTo(@98);
        }];
    }
    return _catEarView;
}

- (UIImageView *)placeHolderView
{
    if (!_placeHolderView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.contentView.bounds;
        imageView.image = [UIImage imageNamed:@"profile_user_414x414"];
        [self.contentView addSubview:imageView];
        _placeHolderView = imageView;
        [self.fatherVC showGifLoding:nil inView:self.placeHolderView];
        // 强制布局
        [_placeHolderView layoutIfNeeded];
    }
    return _placeHolderView;
}
- (UIImageView *)otherView
{
    if (!_otherView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"private_icon_70x70"]];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOtherView)]];
        [self.moviePlayer.view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.catEarView);
            make.bottom.equalTo(self.catEarView.mas_top).offset(-40);
        }];
        _otherView = imageView;
    }
    return _otherView;
}
- (void)setLive:(GHZLiveNewModel *)live
{
    _live = live;
    self.topView.liveNewModel = live;
    //播放
    [self plarFLV:live.flv placeHolderUrl:live.bigpic];
}
- (void)setRelateLive:(GHZLiveNewModel *)relateLive
{
    _relateLive = relateLive;
    if (relateLive) {
        self.catEarView.model = relateLive;
    }else
    {
        self.catEarView.hidden = YES;
    }
}
- (CAEmitterLayer *)emitterLayer
{
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        // 开启三维效果
        //    _emitterLayer.preservesDepth = YES;
        NSMutableArray *array = [NSMutableArray array];
        // 创建粒子
        for (int i = 0; i<10; i++) {
            // 发射单元
            CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
            // 粒子的创建速率，默认为1/s
            stepCell.birthRate = 1;
            // 粒子存活时间
            stepCell.lifetime = arc4random_uniform(4) + 1;
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            // 颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
            // 粒子显示的内容
            stepCell.contents = (id)[image CGImage];
            // 粒子的名字
            //            [fire setName:@"step%d", i];
            // 粒子的运动速度
            stepCell.velocity = arc4random_uniform(100) + 100;
            // 粒子速度的容差
            stepCell.velocityRange = 80;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = M_PI+M_PI_2;;
            // 粒子发射角度的容差
            stepCell.emissionRange = M_PI_2/6;
            // 缩放比例
            stepCell.scale = 0.3;
            [array addObject:stepCell];
        }
        
        emitterLayer.emitterCells = array;
        [self.moviePlayer.view.layer insertSublayer:emitterLayer below:self.catEarView.layer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}

#pragma mark - 工具方法
//退出播放
- (void)exit
{
    if (_catEarView) {
        [_catEarView removeFromSuperview];
        _catEarView = nil;
    }
    
    if (_moviePlayer) {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
//    [_renderer stop];
//    [_renderer.view removeFromSuperview];
//    _renderer = nil;
    [self.fatherVC dismissViewControllerAnimated:YES completion:nil];
}
//播放方法
- (void)plarFLV:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl
{
    if (_moviePlayer) {
        if (_moviePlayer) {
            [self.contentView insertSubview:self.placeHolderView aboveSubview:_moviePlayer.view];
        }
        if (_catEarView) {
            [_catEarView removeFromSuperview];
            _catEarView = nil;
        }
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    // 如果切换主播, 取消之前的动画
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:placeHolderUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.fatherVC showGifLoding:nil inView:self.placeHolderView];
            self.placeHolderView.image = [UIImage blurImage:image blur:0.8];
        });
    }];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];

    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    self.moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
   self.moviePlayer.view.frame = self.contentView.bounds;
    // 填充fill
    self.moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    self.moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    self.moviePlayer.shouldShowHudView = NO;
    
    [self.contentView insertSubview:self.moviePlayer.view atIndex:0];
    
    [self.moviePlayer prepareToPlay];
    
    
    // 设置监听
    [self setObserver];
    
    // 显示工会其他主播和类似主播
    [self.moviePlayer.view bringSubviewToFront:self.otherView];
    
    // 开始来访动画
    [self.emitterLayer setHidden:NO];

    
}
/**  点击了关联的主播 */
- (void)clickCatEarView
{
    if (self.clickRelatedLive) {
        self.clickRelatedLive();
    }
}
- (void)clickOtherView
{
    NSLog(@"点击了相关的主播");
}
#pragma mark - 通知相关
- (void)setObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerDidFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerStatusDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}
//播放完成
- (void)moviePlayerDidFinish
{
//    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.fatherVC.gifView) {
        [self.fatherVC showGifLoding:nil inView:self.moviePlayer.view];
        return;
    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] GET:self.live.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功%@, 等待继续播放", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
        [weakSelf.moviePlayer shutdown];
        [weakSelf.moviePlayer.view removeFromSuperview];
        weakSelf.moviePlayer = nil;
        weakSelf.endView.hidden = NO;
    }];
}
//播放状态的改变
- (void)moviePlayerStatusDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        //可以播放了
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeHolderView) {
                    [_placeHolderView removeFromSuperview];
                    _placeHolderView = nil;
//                    [self.moviePlayer.view addSubview:_renderer.view];
                }
                [self.fatherVC hideGufLoding];
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            if (self.fatherVC.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.fatherVC hideGufLoding];
                });
                
            }
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        [self.fatherVC showGifLoding:nil inView:self.moviePlayer.view];
    }
}
@end
