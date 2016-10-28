//
//  NSDate+GHZExtension.h
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (GHZExtension)
/**
 *比较from 和self的时间差
 */
-(NSDateComponents *)deltaFrom:(NSDate *)from;
/**
 * 是否为今年
 */
-(BOOL)isThisYear;
/**
 * 是否为今天
 */
-(BOOL)isToday;
/**
 * 是否为昨天
 */
-(BOOL)isYesterday;
@end
