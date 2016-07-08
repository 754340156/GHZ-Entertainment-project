//
//  GHZLivingViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZLivingViewController.h"
#import "GHZBottomView.h"
#import <Masonry/Masonry.h>
@interface GHZLivingViewController ()
@property (nonatomic,strong)GHZBottomView *bottomView;
@end

@implementation GHZLivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self setBottomView];
}

- (void)setBottomView
{
    self.bottomView = [GHZBottomView GHZ_viewFromXib];
    self.bottomView.frame = CGRectMake(0, GHZScreenHeight - livingBottomHeight, GHZScreenWidth, livingBottomHeight);
    [self.view addSubview:self.bottomView];
    self.bottomView.bottomClickAction = ^(LiveBottomButtonType type)
    {
        //点击了哪个按钮
        NSLog(@"%ld",type);
    };

}
@end
