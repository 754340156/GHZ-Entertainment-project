//
//  GHZShowEndView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/11.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZShowEndView : UIView

/**  返回首页按钮 */
@property (nonatomic,copy) void (^backAction)(UIButton *);
/**  删除视频 */
@property (nonatomic,copy) void (^deleteAction)(UIButton *);

@end
