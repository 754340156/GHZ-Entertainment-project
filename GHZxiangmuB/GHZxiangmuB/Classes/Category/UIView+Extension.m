//
//  UIView+Extension.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/7.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (BOOL)GHZ_intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

+ (instancetype)GHZ_viewFromXib
{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (CGFloat)GHZ_centerX
{
    return self.center.x;
}
- (void)setGHZ_centerX:(CGFloat)GHZ_centerX
{
    CGPoint center = self.center;
    center.x = GHZ_centerX;
    self.center = center;
}
- (CGFloat)GHZ_centerY
{
    return self.center.y;
}
- (void)setGHZ_centerY:(CGFloat)GHZ_centerY
{
    CGPoint center = self.center;
    center.y = GHZ_centerY;
    self.center = center;
}
- (CGSize)GHZ_size
{
    return self.frame.size;
}

- (void)setGHZ_size:(CGSize)GHZ_size
{
    CGRect frame = self.frame;
    frame.size = GHZ_size;
    self.frame = frame;
}

- (CGFloat)GHZ_width
{
    return self.frame.size.width;
}

- (CGFloat)GHZ_height
{
    return self.frame.size.height;
}

- (void)setGHZ_width:(CGFloat)GHZ_width
{
    CGRect frame = self.frame;
    frame.size.width = GHZ_width;
    self.frame = frame;
}
- (void)setGHZ_height:(CGFloat)GHZ_height
{
    CGRect frame = self.frame;
    frame.size.height = GHZ_height;
    self.frame = frame;
}

- (CGFloat)GHZ_x
{
    return self.frame.origin.x;
}

- (void)setGHZ_x:(CGFloat)GHZ_x
{
    CGRect frame = self.frame;
    frame.origin.x = GHZ_x;
    self.frame = frame;
}

- (CGFloat)GHZ_y
{
    return self.frame.origin.y;
}

- (void)setGHZ_y:(CGFloat)GHZ_y
{
    CGRect frame = self.frame;
    frame.origin.y = GHZ_y;
    self.frame = frame;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

@end
