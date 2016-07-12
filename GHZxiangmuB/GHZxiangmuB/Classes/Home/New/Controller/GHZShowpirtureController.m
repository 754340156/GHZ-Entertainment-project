//
//  GHZShowpirtureController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZShowpirtureController.h"
#import "UIImageView+WebCache.h"
#import "GHZTopicModel.h"
@interface GHZShowpirtureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation GHZShowpirtureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //宽
    //图片宽度 高度
    UIImageView *imageView = [[UIImageView alloc] init];

    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    CGFloat pictureW = GHZScreenWidth;
    CGFloat pictureH = pictureW * self.model.height /self.model.width;
    if (pictureH > GHZScreenHeight) {
        //需要滚动
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.GHZ_centerY = GHZScreenHeight *0.5;
    }
      [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.bigImage]];
    
}
-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)save{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image,self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
 
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"%@",error);
    if (error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"保存失败!";
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
