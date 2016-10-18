//
//  NSString+GHZTime.m
//  GHZxiangmuB
//
//  Created by    on 16/7/13.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "NSString+GHZTime.h"

@implementation NSString (GHZTime)
+(NSString *)stringWithTime:(NSTimeInterval)time{
    NSInteger m = time / 60;
    NSInteger second = (NSInteger)time %60;
    return [NSString stringWithFormat:@"%02ld:%02ld",m,second];
}
@end
