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

@end

@implementation GHZShowpirtureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //宽
    //图片宽度 高度
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    
    CGFloat pictureW = GHZScreenWidth;
    CGFloat pictureH = pictureW * self.model.height /self.model.width;
    if (pictureH > GHZScreenHeight) {
        //需要滚动
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.GHZ_centerY = GHZScreenWidth *0.5;
    }
      [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.bigImage]];
}

@end
