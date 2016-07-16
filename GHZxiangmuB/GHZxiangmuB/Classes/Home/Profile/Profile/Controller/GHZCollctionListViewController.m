//
//  GHZCollctionListViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZCollctionListViewController.h"
#import "GHZCollectionView.h"
#import "GHZNewCollectionView.h"
@interface GHZCollctionListViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)UISegmentedControl *segmentedControl;
@end

@implementation GHZCollctionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"精华",@"新帖"]];
    }
    return _segmentedControl;
}

@end
