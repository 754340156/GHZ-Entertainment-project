//
//  UIBarButtonItem+GHZExtention.m
//  GHZxiangmuB
//
//  Created by    on 16/7/8.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "UIBarButtonItem+GHZExtention.h"

@implementation UIBarButtonItem (GHZExtention)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage target:(id)target action:(SEL)action{

    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [Button setBackgroundImage:[UIImage imageNamed:hightImage] forState:(UIControlStateHighlighted)];
    Button.GHZ_size = Button.currentBackgroundImage.size;
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:Button];

}



@end
