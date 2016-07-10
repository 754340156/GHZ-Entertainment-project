//
//  GHZTopicModel.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHZTopicModel : NSObject
/** 名称*/ 
@property (nonatomic,strong)NSString *name;
/** 头像*/
@property (nonatomic,strong)NSString *profile_image;
/** 发帖时间*/
@property (nonatomic,strong)NSString *create_time;
/** 文字*/
@property (nonatomic,strong)NSString *text;
/**顶 */
@property (nonatomic,assign)NSInteger ding;
/**踩 */
@property (nonatomic,assign)NSInteger cai;
/**转发 */
@property (nonatomic,assign)NSInteger repost;
/**评论 */
@property (nonatomic,assign)NSInteger comment;
/**是否新浪V */
@property (nonatomic,assign,getter=isSina_V) BOOL sina_v;
@end