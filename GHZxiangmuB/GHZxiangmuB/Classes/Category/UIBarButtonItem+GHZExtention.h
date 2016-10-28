//
//  UIBarButtonItem+GHZExtention.h
//  GHZxiangmuB
//
//  Created by    on 16/7/8.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GHZExtention)
/**
 创建导航栏两侧按钮 */
+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action;

@end
