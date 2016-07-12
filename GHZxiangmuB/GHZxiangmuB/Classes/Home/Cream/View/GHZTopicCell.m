//
//  GHZTopicCell.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTopicCell.h"
#import "GHZTopic.h"
#import "UIImageView+WebCache.h"

@interface GHZTopicCell ()
//头像
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
//昵称
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
//时间
@property (strong, nonatomic) IBOutlet UILabel *createTimeLabel;
//顶
@property (strong, nonatomic) IBOutlet UIButton *dingButton;
//踩
@property (strong, nonatomic) IBOutlet UIButton *caiButton;
//分享
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
//评论
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
//新浪加 V
@property (strong, nonatomic) IBOutlet UIImageView *sinaVView;

@end


@implementation GHZTopicCell

- (void)awakeFromNib{

    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;

}

- (void)setTopic:(GHZTopic *)topic{

    _topic = topic;
    
    //新浪加 V
    self.sinaVView.hidden = !topic.sina_v;
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置名字
    self.nameLabel.text = topic.name;
    
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
   
    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton  count:topic.comment placeholder:@"评论"];
    
    //[self testDate:topic.create_time];
    
}

//- (void)testDate:(NSString *)create_time{
//    
//
//    
//    
//    //日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    //比较时间
//    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *cmps = [calendar components:unit fromDate:create toDate:now options:0];
//    
//    
//    //获得 NSDate 的每一个元素
////    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
////    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:now];
////    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:now];
//    
////    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:now];
////    GHZLog(@"%@",cmps);
//}




//- (void)testDate:(NSString *)create_time{
//    //当前时间
//    NSDate *now = [NSDate date];
//    //发帖时间
//    //NSString -> NSDate
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式(y:年 M: 月 d: 天, H: 小时, m: 分, s: 秒)
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *create = [fmt dateFromString:create_time];
//    NSTimeInterval dalta = [now timeIntervalSinceDate:create];
//    GHZLog(@"%f",dalta);
//}

//设置各个按钮的显示文字
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:(UIControlStateNormal)];
}


- (void)setFrame:(CGRect)frame{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
