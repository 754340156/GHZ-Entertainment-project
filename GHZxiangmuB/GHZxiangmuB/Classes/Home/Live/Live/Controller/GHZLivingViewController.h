//
//  GHZLivingViewController.h
//  GHZxiangmuB
//
//  Created by    on 16/7/8.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZViewController.h"

@interface GHZLivingViewController : GHZViewController
/**  直播的数组 */
@property (nonatomic,strong) NSArray *livingModels;
/**  当前的直播索引 */
@property (nonatomic,assign) NSInteger currentIndex;
@end
