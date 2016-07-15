//
//  GHZPictureView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewPictureView.h"
#import "GHZTopicModel.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "GHZShowpirtureController.h"
#import <DALabeledCircularProgressView.h>
@interface GHZNewPictureView ()
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**gif*/
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**查看*/
@property (weak, nonatomic) IBOutlet UIButton *lookButton;
@property (nonatomic,strong) MBProgressHUD *hud;
/**进度条*/
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *Loding;


@end

@implementation GHZNewPictureView
+(instancetype)pictureView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    self.Loding.roundedCorners = 2;
    self.Loding.progressTintColor = [UIColor whiteColor];
}
-(void)showPicture{
    GHZShowpirtureController *show = [[GHZShowpirtureController alloc] init];
    show.model = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:show animated:YES completion:nil];
        
  
}
-(IBAction)play{
    
}
-(void)setModel:(GHZTopicModel *)model{
    _model = model;
    
    /**
     *在不知道图片扩展名的情况下,取出第一个字节就能知道图片的类型
     */
    [self.Loding setProgress:model.progressTime animated:NO];
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage] placeholderImage:[UIImage imageNamed:@""]];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.Loding.hidden = NO;
        model.progressTime = 1.0 * receivedSize / expectedSize;
        model.progressTime = (model.progressTime < 0?0 :model.progressTime);
        [self.Loding setProgress:model.progressTime animated:NO];
        self.Loding.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",model.progressTime * 100];
        self.Loding.progressLabel.alpha = 0.5;
        
           } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
               self.Loding.hidden = YES;
               if (model.longPicture==NO) {
                   return ;
               }
               //s图像上下文
               UIGraphicsBeginImageContextWithOptions(model.pictureViewFrame.size, YES, 0.0);
               //将下载的图片绘制到图形上下文
               CGFloat with = model.pictureViewFrame.size.width;
               CGFloat height = with *image.size.height / image.size.width;
               [image drawInRect:CGRectMake(0, 0, with, height)];

               //获取图片
               self.imageView.image =
               UIGraphicsGetImageFromCurrentImageContext();
               //结束上下文
               UIGraphicsEndImageContext();
               
           }];
    
    
    //判断是否为gif
    NSString *extension = model.bigImage.pathExtension;
    //判断是否为gif
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //判断高度是否超过规定值
    if (model.longPicture) {
        
        self.lookButton.hidden = NO;
        //self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.lookButton.hidden = YES;
        //self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

@end
