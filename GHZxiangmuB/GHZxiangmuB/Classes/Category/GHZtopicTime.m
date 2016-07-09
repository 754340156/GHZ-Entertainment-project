//
//  GHZtopicTime.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZtopicTime.h"

@implementation GHZtopicTime
-(NSString *)create_time{
    
    //发帖时间
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    //设置日期格式      年   月 日  时 分 秒
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *create = [f dateFromString:_cre];
    if (create.isThisYear) {//今年
        if (create.isToday) {//今天
            NSDateComponents *cmp = [[NSDate date] deltaFrom:create];
            if (cmp.hour>=1) {//大于等于一小时
                self.createTimeLabel.text = [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if(cmp.minute>=1){//大于等于一份
                self.createTimeLabel.text = [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else{ //小于一分
                self.createTimeLabel.text = @"刚刚";
            }
        }else if (create.isYesterday){//昨天
            f.dateFormat = @"昨天 HH:mm:ss";
            self.textLabel.text = [f stringFromDate:create];
        }else{//其他
            f.dateFormat = @"MM-dd HH:mm:ss";
            self.textLabel.text = [f stringFromDate:create];
        }
    }else{//非今年
        self.textLabel.text = model.create_time;
    }

    
    
    
}
@end
