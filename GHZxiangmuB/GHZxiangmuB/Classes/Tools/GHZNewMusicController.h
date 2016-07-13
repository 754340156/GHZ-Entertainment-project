//
//  GHZNewMusicController.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface GHZNewMusicController : UIViewController
@property (nonatomic,copy)NSString *url;
@property (nonatomic,assign) NSInteger totalTime;
-(void)dismiss;
@end
