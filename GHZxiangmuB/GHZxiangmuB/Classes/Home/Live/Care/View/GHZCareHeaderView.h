//
//  GHZCareHeaderView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/10.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZCareHeaderView : UIView


/**  点击了去看主播按钮 */
@property (nonatomic,copy) void (^lookUserAction)(UIButton *);
@end
