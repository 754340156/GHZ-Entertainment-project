//
//  GHZShowPictureViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "GHZTopic.h"
#import <MBProgressHUD.h>
#import "GHZCreamProgressView.h"
#import "UMSocial.h"
@interface GHZShowPictureViewController ()<UMSocialUIDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet GHZCreamProgressView *progressView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GHZShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕尺寸
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > screenH) {  //图片显示的高度超过一个屏幕
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
    
       imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.GHZ_centerY = screenH * 0.5;
    }
    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)save {
    
    if (self.imageView.image == nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"图片没有下载完毕";
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)shareButton:(id)sender {
    
    NSString *url = [[NSString alloc] init];
    if (_topic.type == Video ) {
        url = _topic.videouri;
    }else if (_topic.type == Music){
        
        url = _topic.voiceuri;
    }else if(_topic.type == Picture){
        
        url = _topic.large_image;
    }

    if (!(_topic.type == Word)) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:_topic.large_image];
        
    }
    
    [UMSocialData defaultData].extConfig.title = @"分享 title";
    [UMSocialData defaultData].extConfig.qqData.url = @"www.baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57490f1ee0f55a75d5002f3f"
                                      shareText:[NSString stringWithFormat:@"%@%@",_topic.text, url]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
}



- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"保存失败";
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }else{
    
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"保存成功";
        hud.mode = MBProgressHUDModeCustomView;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    
    }
}

@end
