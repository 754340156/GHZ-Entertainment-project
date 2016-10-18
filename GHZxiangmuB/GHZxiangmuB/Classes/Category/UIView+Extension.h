//
//  UIView+Extension.h
//  GHZxiangmuB
//
//  Created by    on 16/7/7.
//  Copyright © 2016年  赵哲. All rights reserved.
//
//快速设置或获取uiview的坐标的分类
#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  快速设置控件的位置
 */
@property (nonatomic, assign) CGSize GHZ_size;
@property (nonatomic, assign) CGFloat GHZ_width;
@property (nonatomic, assign) CGFloat GHZ_height;
@property (nonatomic, assign) CGFloat GHZ_x;
@property (nonatomic, assign) CGFloat GHZ_y;
@property (nonatomic, assign) CGFloat GHZ_centerX;
@property (nonatomic, assign) CGFloat GHZ_centerY;
@property(nonatomic,assign)CGSize size;
/**
 *  快速根据xib创建View
 */
+ (instancetype)GHZ_viewFromXib;

/**
 *  判断self和view是否重叠
 */
- (BOOL)GHZ_intersectsWithView:(UIView *)view;
@end
