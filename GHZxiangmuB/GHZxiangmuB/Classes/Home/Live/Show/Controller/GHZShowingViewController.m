//
//  GHZShowingViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/10.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZShowingViewController.h"
#import "GHZShowPlaceHolderView.h"
#import "GHZShowLivingView.h"
#import "GHZShowEndView.h"
#import <LFLiveKit.h>
@interface GHZShowingViewController ()<LFLiveSessionDelegate>
/**  直播前的占位view */
@property (nonatomic,strong) GHZShowPlaceHolderView *showPHView;
/**  直播类 */
@property (nonatomic,strong) LFLiveSession *session;
/**  直播的view */
@property (nonatomic,weak) GHZShowLivingView *livingView;
/**  直播结束的view */
@property (nonatomic,strong) GHZShowEndView *endView;;
@end

@implementation GHZShowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //设置占位的直播图片
    self.showPHView = [GHZShowPlaceHolderView GHZ_viewFromXib];
    [self.view addSubview:self.showPHView];
    [self setPlaceHolderBlock];
}

- (void)setPlaceHolderBlock
{
     __weak typeof(self)weakself = self;
    //直播
    self.showPHView.startShowingAction = ^(UIButton *button)
    {
         [weakself.showPHView removeFromSuperview];
        [weakself startShowing];
    };
    //关闭
    self.showPHView.closeAction = ^(UIButton *button)
    {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    };
}
- (void)setShowingBlock
{
     __weak typeof(self)weakself = self;
    
    //美颜
    _livingView.beautifulAction = ^(UIButton *beautifulButton)
    {
        beautifulButton.selected = !beautifulButton.selected;
        // 默认是开启了美颜功能的
        weakself.session.beautyFace = !weakself.session.beautyFace;
        NSLog(@"美颜");
    };
    //切换摄像头
    _livingView.cameraAction = ^(UIButton *cameraButton)
    {
        AVCaptureDevicePosition devicePositon = weakself.session.captureDevicePosition;
        weakself.session.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
        NSLog(@"切换摄像头");
    };
    //关闭直播
    _livingView.closeAction = ^(UIButton *closeButton)
    {
        [weakself.session stopLive];
        weakself.endView.backAction = ^(UIButton *backbutton)
        {
            [weakself dismissViewControllerAnimated:YES completion:nil];
        };
        NSLog(@"关闭直播");
    };
}
#pragma mark - 直播
- (void)startShowing
{
    LFLiveStreamInfo *info = [[LFLiveStreamInfo alloc] init];
    info.url = rtmpUrl;
    [self.session startLive:info];
}
#pragma mark -- LFStreamingSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    NSLog(@"%@",tempStatus);
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    NSLog(@"%@",debugInfo);
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    NSLog(@"%lu",(unsigned long)errorCode);
}
#pragma mark - 懒加载

- (LFLiveSession *)session
{
    if (!_session) {
        /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2] liveType:LFLiveRTMP];
        // 设置代理
        _session.delegate = self;
        _session.running = YES;
        _session.preView = self.livingView;
//         默认开启后置摄像头
        _session.captureDevicePosition = AVCaptureDevicePositionBack;
    }
    return _session;
}

- (GHZShowLivingView *)livingView
{
    if (!_livingView) {
        _livingView = [GHZShowLivingView GHZ_viewFromXib];
        _livingView.backgroundColor = [UIColor clearColor];
        _livingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self setShowingBlock];
        [self.view addSubview:_livingView];;
    }
    return _livingView;
}
- (GHZShowEndView *)endView
{
    if (!_endView) {
        _endView = [GHZShowEndView GHZ_viewFromXib];
        [self.view addSubview:_endView];
    }
    return _endView;
}
@end
