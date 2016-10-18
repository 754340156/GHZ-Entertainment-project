//
//  CoreLaunchLite.m
//  xiangmu
//
//  Created by    on 16/7/6.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "CoreLaunchLite.h"
#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)
@implementation CoreLaunchLite
/** 执行动画 */
+(void)animWithWindow:(UIWindow *)window image:(UIImage *)image{
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    imageV.image = [self launchImage];
    
    [window.rootViewController.view addSubview:imageV];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [UIView animateWithDuration:1.5 animations:^{
            
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            
            imageV.transform=CGAffineTransformMakeScale(2.f, 2.f);
            imageV.alpha = 0;
            
            
        } completion:^(BOOL finished) {
            
            [imageV removeFromSuperview];
            
        }];
        
    });
}
/**
 *  获取启动图片
 */
+(UIImage *)launchImage{
//    NSString *imageName= @"Default-375w";
    
//    if(iphone5x_4_0) imageName= @"Default-1";
//    
//    if(iphone6_4_7) imageName = @"Default-375w";
//    
//    if(iphone6Plus_5_5) imageName = @"Default-414w";
    
    UIImage *image = [UIImage imageNamed:@"Default-375w"];
    
//    NSAssert(image != nil, @"Charlin Feng提示您：请添加启动图片！");
    
    return image;

    
    
}
@end
