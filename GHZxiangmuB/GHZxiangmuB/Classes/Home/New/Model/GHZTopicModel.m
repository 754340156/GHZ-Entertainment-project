//
//  GHZTopicModel.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTopicModel.h"
//#import <MJExtension/MJExtension.h>


@implementation GHZTopicModel
{
    CGFloat _cellHeight;
    CGRect _pictureViewFrame;
}

//setvalueforundefinde key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"smallImage" : @"image0",@"bigImage" : @"image1",@"middleImage" : @"image2"};
}


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
/**计算cell的高度*/
-(CGFloat)cellHeight{
    if (!_cellHeight) {
        //文字的范围
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-GHZCellTextX*4, MAXFLOAT);
        //文字搞
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight = GHZCellTextY + textH + GHZCellmargin ;
        //根据段子类型判断cell高度
        if (self.type == Picture) {
            //图片宽度
            CGFloat pictureW = maxSize.width;
            //显示高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= GHZCellPictureMaxH) {
                pictureH = GHZCellPictureBreakH;
                self.longPicture = YES;
            }
            //计算出图片的frame
            CGFloat pictureX = GHZCellTextX;
            CGFloat pictureY = GHZCellTextY + textH + GHZCellmargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + GHZCellmargin;
        }else if (self.type == Music){ //声音
            CGFloat musicX = GHZCellTextX;
            CGFloat musicY = GHZCellTextY + textH + GHZCellmargin;
            CGFloat musicW = maxSize.width;
            CGFloat musicH = musicW * self.height / self.width;
            _musicViewFrame = CGRectMake(musicX, musicY, musicW, musicH);
            _cellHeight += GHZCellmargin + musicH;
        } if (self.type == Video) {
            CGFloat videoX = GHZCellTextX;
            CGFloat videoY = GHZCellTextY + textH + GHZCellmargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight +=GHZCellmargin + videoH;
        }
        //底部
        _cellHeight += GHZCelltoolH + GHZCellmargin;
    }
    return _cellHeight;
}


@end
