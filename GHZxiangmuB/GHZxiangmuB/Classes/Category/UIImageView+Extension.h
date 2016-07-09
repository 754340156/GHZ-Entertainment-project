//
//  UIImageView+Extension.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
/**  播放GIF */
- (void)playGifAnim:(NSArray *)images;
/**  停止动画 */
- (void)stopGifAnim;

@end
