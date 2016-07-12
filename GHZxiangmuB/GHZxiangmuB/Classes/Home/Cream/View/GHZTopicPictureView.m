//
//  GHZTopicPictureView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZTopicPictureView.h"
#import "GHZTopic.h"
#import <UIImageView+WebCache.h>

@interface GHZTopicPictureView ()

//图片
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
// gif 标识
@property (strong, nonatomic) IBOutlet UIImageView *gifView;
//查看大图按钮
@property (strong, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation GHZTopicPictureView

+ (instancetype)pictureView{


    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject]; 

}

- (void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;

}


- (void)setTopic:(GHZTopic *)topic{
    _topic = topic;
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];

}

@end
