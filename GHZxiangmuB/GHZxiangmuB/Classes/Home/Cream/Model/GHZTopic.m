//
//  GHZTopic.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTopic.h"

@implementation GHZTopic
- (NSString *)create_time{
    //日期格式化类: NSString -> NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式(y:年 M: 月 d: 天, H: 小时, m: 分, s: 秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";

    //当前时间
    NSDate *now = [NSDate date];
    //发帖时间
    NSDate *create = [fmt dateFromString:_create_time];
    [now deltaFrom:create];
    if (create.isThisYear) {    //今年
        if (create.isToday) {   //今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) {
                //时间差距 >= 1小时
               return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){    //1小时 > 时间差距 >= 1分钟
                
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
                
            }else { //1分钟  > 时间差距
                return  @"刚刚";
            }
        }else if (create.isYesterday){  //昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return  [fmt stringFromDate:create];
            
        }else{  //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{   //非今年
        return _create_time;
    }

}
@end
