//
//  GHZTopicPictureView.m
//  GHZxiangmuB
//
//  Created by    on 16/7/12.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZTopicPictureView.h"
#import "GHZTopic.h"
#import <UIImageView+WebCache.h>
#import "GHZCreamProgressView.h"
#import "GHZShowPictureViewController.h"

@interface GHZTopicPictureView ()

//图片
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
// gif 标识
@property (strong, nonatomic) IBOutlet UIImageView *gifView;
//查看大图按钮
@property (strong, nonatomic) IBOutlet UIButton *seeBigButton;
//进度条控件
@property (strong, nonatomic) IBOutlet GHZCreamProgressView *ProgressView;

@end

@implementation GHZTopicPictureView

+ (instancetype)pictureView{


    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject]; 

}

- (void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
    
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture{
    GHZShowPictureViewController *showPicture = [[GHZShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil ];
    

}

- (void)setTopic:(GHZTopic *)topic{
    _topic = topic;
    
    //立马显示最新的进度值()
    [self.ProgressView setProgress:topic.pictureProgress animated:NO];
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.ProgressView.hidden = NO;
        
        //计算进度值
        topic.pictureProgress = 1.0*receivedSize / expectedSize;
        //显示进度值
        [self.ProgressView setProgress:topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.ProgressView.hidden = YES;
        
        //如果是大图片, 才需要进行绘图处理
        if (topic.isBigPicture == NO) return;
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        //将下载完的 image 对象绘制到图形的上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //结束上下文
        UIGraphicsEndImageContext();
        
    }];
    //判断是否为 gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //判断是否显示"点击查看全图"按钮
    if (topic.isBigPicture) {  //大图
        self.seeBigButton.hidden = NO;
        

    }else{
        self.seeBigButton.hidden = YES;
        //self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

@end
