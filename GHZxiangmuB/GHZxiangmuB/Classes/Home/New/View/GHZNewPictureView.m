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
@interface GHZNewPictureView ()
/**图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**gif*/
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**查看*/
@property (weak, nonatomic) IBOutlet UIButton *lookButton;
@property (weak, nonatomic) IBOutlet UIView *loding;
@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation GHZNewPictureView
+(instancetype)pictureView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}
-(void)showPicture{
    NSLog(@"qweqwe");
    GHZShowpirtureController *show = [[GHZShowpirtureController alloc] init];
    show.model = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:show animated:YES completion:nil];
        
  
}

-(void)setModel:(GHZTopicModel *)model{
    _model = model;
    
    /**
     *在不知道图片扩展名的情况下,取出第一个字节就能知道图片的类型
     */
    
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage] placeholderImage:[UIImage imageNamed:@""]];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
      
           } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         }];
    
    //判断是否为gif
    NSString *extension = model.bigImage.pathExtension;
    //判断是否为gif
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //判断高度是否超过规定值
    if (model.longPicture) {
        
        self.lookButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.lookButton.hidden = YES;
    }
    
}

@end
