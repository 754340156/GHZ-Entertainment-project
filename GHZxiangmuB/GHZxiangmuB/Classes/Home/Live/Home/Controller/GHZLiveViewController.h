//
//  GHZLiveViewController.h
//  GHZxiangmuB
//
//  Created by    on 16/7/7.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZViewController.h"
@class GHZSelectedView;
@interface GHZLiveViewController : GHZViewController
/**  ScrollView */
@property (nonatomic,strong)UIScrollView *contentView;
/**  顶部选择器 */
@property (nonatomic,strong) GHZSelectedView *topMenuView;
@end
