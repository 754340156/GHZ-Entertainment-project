//
//  GHZNewWordCell.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewWordCell.h"
#import "GHZTopicModel.h"
#import "GHZPictureView.h"
#import "UIImageView+WebCache.h"
@interface GHZNewWordCell ()
/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享*/
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论*/
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
/** 新浪用户V*/
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/**文本内容*/
@property (weak, nonatomic) IBOutlet UILabel *TextsLabel;
/**图片中间的view*/
@property (nonatomic,weak)GHZPictureView *pictureView;
@end

@implementation GHZNewWordCell

-(GHZPictureView *)pictureView{
    if (!_pictureView) {
        GHZPictureView *pictureView = [GHZPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}



-(void)awakeFromNib{
    UIImageView *bjView = [[UIImageView alloc] init];
    bjView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bjView;
}
/**
 * 今年
     今天
       1分钟内
            刚刚
         1小时内
           xx分中前
          qita
            xx小时前
  昨天
    昨天 时:分:秒
 其他
 月-日 时:分:秒
 飞今年 就正常年月日
 
 */
-(void)setModel:(GHZTopicModel *)model{
    _model = model;
//页面参数
    //新浪V
    self.sinaVView.hidden = !model.sina_v;
    //头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@""]];
    //昵称
    self.nameLabel.text = model.name;
    //设置时间
    self.createTimeLabel.text = model.create_time;
//按钮参数
    [self ButtonTitle:self.dingButton count:model.ding placeholder:@"顶"];
    [self ButtonTitle:self.caiButton count:model.cai placeholder:@"踩"];
    [self ButtonTitle:self.shareButton count:model.repost placeholder:@"分享"];
    [self ButtonTitle:self.commentsButton count:model.comment placeholder:@"评论"];
    self.TextsLabel.text = model.text;
   // NSLog(@"%@",model.text);
   // NSLog(@"%@  %@ %@",model.smallImage,model.bigImage,model.middleImage);
    if (model.type == Picture) { //根据类型把相应的view贴到view上
        self.pictureView.model = model;
        self.pictureView.frame = model.pictureViewFrame;
    }
}
-(void)testDate:(NSString *)create_time
{
        //当前时间
        NSDate *now = [NSDate date];
        //发帖时间
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        //设置日期格式      年   月 日  时 分 秒
        f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *create = [f dateFromString:create_time];
        [now timeIntervalSinceDate:create];
        [now deltaFrom:create];
}


//按钮参数格式
-(void)ButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
   // NSString *title = nil;
     //大于一万之后 参数格式
    if (count>10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else  if(count>0){
        placeholder = [NSString stringWithFormat:@"%ld",count];
    }
    [button setTitle:placeholder forState:(UIControlStateNormal)];
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x = GHZCellmargin ;
    frame.size.width-= 2 * frame.origin.x;
    frame.size.height -= GHZCellmargin;
    frame.origin.y += GHZCellmargin;
    [super setFrame:frame];
}

@end
