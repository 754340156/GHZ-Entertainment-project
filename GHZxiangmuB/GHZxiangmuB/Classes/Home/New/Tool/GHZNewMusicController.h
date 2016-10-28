//
//  GHZNewMusicController.h
//  GHZxiangmuB
//
//  Created by    on 16/7/13.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GHZNewMusicController : UIViewController
@property (nonatomic,copy)NSString *url;
@property (nonatomic,assign) NSInteger totalTime;
/**  销毁 */
- (void)dismiss;
/**  播放完成 */
@property (nonatomic,copy) void (^playerFinish)();
@end
