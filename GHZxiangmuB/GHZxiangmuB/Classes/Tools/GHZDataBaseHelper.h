//
//  GHZDataBaseHelper.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GHZTopicModel,GHZTopic;
@interface GHZDataBaseHelper : NSObject

+ (instancetype)shareInstance;
/**  创建表 */
- (void)create;

/**  插入一个精华数据 */
- (void)insertTopic:(GHZTopic *)topic;
/**  查找精华所有数据 */
- (NSMutableArray *)searchTopics;
/**  删除精华某条数据 */
- (void)deleteTopicWithcreate_time:(NSString *)create_time;


/**  插入一个新帖数据 */
- (void)insertTopicModel:(GHZTopicModel *)topicModel;
/**  查找新帖所有数据 */
- (NSMutableArray *)searchTopicModels;
/**  删除新帖某条数据 */
- (void)deleteTopicModelWithcreate_time:(NSString *)create_time;
@end
