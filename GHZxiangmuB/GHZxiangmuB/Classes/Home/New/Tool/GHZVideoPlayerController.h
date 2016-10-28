//
//  GHZVideoPlayerController.h
//  GHZxiangmuB
//
//  Created by    on 16/7/16.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>


@interface GHZVideoPlayerController : MPMoviePlayerController

@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
@property (nonatomic, assign) CGRect frame;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)showInWindow;
- (void)dismiss;

@end
