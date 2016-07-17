//
//  GHZTopicCell.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopic;

@protocol GHZTopicCellDelegate <NSObject>
/** 点击分享按钮 */
- (void)getClick:(NSString *)image url:(NSString *)url text:(NSString *)text;
/** 点击评论按钮 */
- (void)getCommentClickWithModel:(GHZTopic *)model;
@end


@interface GHZTopicCell : UITableViewCell
/**帖子数据*/
@property(nonatomic, strong)  GHZTopic *topic;

@property (nonatomic, weak) id <GHZTopicCellDelegate> delegate;

@end
