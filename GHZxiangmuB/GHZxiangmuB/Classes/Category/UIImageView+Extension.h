//
//  UIImageView+Extension.h
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
/**  播放GIF */
- (void)playGifAnim:(NSArray *)images;
/**  停止动画 */
- (void)stopGifAnim;

@end
