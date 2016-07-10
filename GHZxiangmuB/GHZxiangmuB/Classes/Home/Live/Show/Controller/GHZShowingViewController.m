//
//  GHZShowingViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/10.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZShowingViewController.h"
#import "GHZShowPlaceHolderView.h"
@interface GHZShowingViewController ()

@end

@implementation GHZShowingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GHZShowPlaceHolderView *showPHView = [GHZShowPlaceHolderView GHZ_viewFromXib];
    [self.view addSubview:showPHView];
    showPHView.closeAction =^(UIButton *button)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
