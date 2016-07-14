//
//  NSString+GHZTime.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "NSString+GHZTime.h"

@implementation NSString (GHZTime)
+(NSString *)stringWithTime:(NSTimeInterval)time{
    NSInteger m = time / 60;
    NSInteger second = (NSInteger)time %60;
    return [NSString stringWithFormat:@"%02ld:%02ld",m,second];
}
@end
