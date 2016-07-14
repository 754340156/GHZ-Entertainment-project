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
#import "GHZTopicPictureView.h"

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
//帖子的文字内容
@property (strong, nonatomic) IBOutlet UILabel *text_Label;
//图片帖子中间的内容
@property (nonatomic, weak) GHZTopicPictureView *pictureView;

@end


@implementation GHZTopicCell

//懒加载
- (GHZTopicPictureView *)pictureView{

    if (!_pictureView) {
        GHZTopicPictureView *pictureView = [GHZTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}



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
    //设置帖子的文字内容
    self.text_Label.text = topic.text;
    
    //根据模型的类型(帖子内容)添加对应的内容到 cell 的中间
    if (topic.type == Picture) {  //图片帖子
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }
    
}


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
    
    frame.origin.x = GHZCellmargin;
    frame.size.width -= 2 * GHZCellmargin;
    frame.size.height -= GHZCellmargin;
    frame.origin.y += GHZCellmargin;
    
    [super setFrame:frame];
    
   
}

@end
