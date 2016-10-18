//
//  GHZNewWordCell.h
//  GHZxiangmuB
//
//  Created by    on 16/7/9.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHZNewVideoView.h"
@class GHZTopicModel;
@protocol GHZNewWordCellDelegate <NSObject>
/**  点击分享按钮 */
- (void)getclick:(NSString *)image url:(NSString *)url text:(NSString *)text;
/**  点击评论按钮*/
- (void)getClickCommentWithModel:(GHZTopicModel *)model;
/**  点击收藏按钮 */
- (void)getClickCollectWithModel:(GHZTopicModel *)model;
@end
@interface GHZNewWordCell : UITableViewCell
/** 段子model*/
@property (nonatomic,strong)GHZTopicModel *model;
@property (nonatomic,weak)id <GHZNewWordCellDelegate>delegate;

@end
