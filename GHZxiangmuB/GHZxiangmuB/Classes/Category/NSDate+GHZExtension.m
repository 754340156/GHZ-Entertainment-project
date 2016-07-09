//
//  NSDate+GHZExtension.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "NSDate+GHZExtension.h"

@implementation NSDate (GHZExtension)

-(NSDateComponents *)deltaFrom:(NSDate *)from{
    
    //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}

-(BOOL)isThisYear{
  //日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYearForWeekOfYear fromDate:self];
    return nowYear == selfYear;
}

-(BOOL)isToday{
 
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [f stringFromDate:[NSDate date]];
    NSString *selfStr = [f stringFromDate:self];
    return [nowStr isEqualToString:selfStr];
}

-(BOOL)isYesterday{
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yyyy-MM-dd";
    NSDate *nowStr = [f dateFromString:[f stringFromDate:[NSDate date]]];
    NSDate *selfStr = [f dateFromString:[f stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:selfStr toDate:nowStr options:0];
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 1;
    
    return YES;
}





@end
