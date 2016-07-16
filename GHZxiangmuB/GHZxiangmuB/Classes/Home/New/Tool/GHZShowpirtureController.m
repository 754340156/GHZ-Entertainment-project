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
#import "UMSocial.h"
@interface GHZShowpirtureController ()<UMSocialUIDelegate,UMSocialDataDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)MBProgressHUD *hud;
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
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeCustomView;
       self.hud.labelText = @"保存失败";
            self.hud.removeFromSuperViewOnHide = YES;
           [self.hud hide:YES afterDelay:1];
    }else{
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeCustomView;
        self.hud.labelText = @"保存成功";
        self.hud.removeFromSuperViewOnHide = YES;
       [self.hud hide:YES afterDelay:1];
    }
}
- (IBAction)shareButtons:(id)sender {
    
    if (!(_model.type == Word)) {
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:_model.bigImage];
        
    }
    [UMSocialData defaultData].extConfig.title = @"分享 title";
    [UMSocialData defaultData].extConfig.qqData.url = @"www.baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57490f1ee0f55a75d5002f3f"
                                      shareText:[NSString stringWithFormat:@"%@%@",_model.text,_model.bigImage]
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];

    
}

@end
