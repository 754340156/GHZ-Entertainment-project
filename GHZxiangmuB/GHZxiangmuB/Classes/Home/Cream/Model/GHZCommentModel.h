//
//  GHZCommentModel.h
//  GHZxiangmuB
//
//  Created by    on 16/7/17.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GHzCommentUserModel;
@interface GHZCommentModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) GHzCommentUserModel *user;
/** 有声音时的行高 */
@property (nonatomic,assign) CGFloat cellHeight;

@end


@interface GHzCommentUserModel : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *profile_image;
@end
