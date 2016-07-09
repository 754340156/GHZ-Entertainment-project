//
//  GHZTopicModel.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTopicModel.h"

@implementation GHZTopicModel
-(NSString *)create_time{
    
    //发帖时间
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //设置日期格式      年   月 日  时 分 秒
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [f dateFromString:_create_time];
    if (create.isThisYear) {//今年
        if (create.isToday) {//今天
            NSDateComponents *cmp = [[NSDate date] deltaFrom:create];
            if (cmp.hour>=1) {//大于等于一小时
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if(cmp.minute>=1){//大于等于一份
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else{ //小于一分
                return @"刚刚";
            }
        }else if (create.isYesterday){//昨天
            f.dateFormat = @"昨天 HH:mm:ss";
            return [f stringFromDate:create];
        }else{//其他
            f.dateFormat = @"MM-dd HH:mm:ss";
            return [f stringFromDate:create];
        }
    }else{//非今年
       return _create_time;
    }
    
    
    
    
}

@end