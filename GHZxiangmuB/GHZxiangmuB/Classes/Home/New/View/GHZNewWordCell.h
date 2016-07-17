//
//  GHZNewWordCell.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHZNewVideoView.h"
@class GHZTopicModel;
@protocol GHZNewWordCellDelegate <NSObject>
/**  点击分享按钮 */
- (void)getclick:(NSString *)image url:(NSString *)url text:(NSString *)text;
/**  点击评论按钮*/
- (void)getClickCommentWithModel:(GHZTopicModel *)model;
@end
@interface GHZNewWordCell : UITableViewCell
/** 段子model*/
@property (nonatomic,strong)GHZTopicModel *model;
@property (nonatomic,weak)id <GHZNewWordCellDelegate>delegate;

@end
