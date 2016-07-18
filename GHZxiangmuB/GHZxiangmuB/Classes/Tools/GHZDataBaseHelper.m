//
//  GHZDataBaseHelper.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZDataBaseHelper.h"
#import "GHZTopicModel.h"
#import "GHZTopic.h"
#import <FMDB.h>
@interface GHZDataBaseHelper ()
@property (nonatomic,strong)FMDatabase *DBhepler;
@end

@implementation GHZDataBaseHelper

static GHZDataBaseHelper *instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GHZDataBaseHelper alloc] init];
    });
    return instance;
}
//获取路径
- (NSString *)path
{
    NSString *str = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",str);
    return [str stringByAppendingPathComponent:@"fmdb.sqlite"];
}

//懒加载db
- (FMDatabase *)DBhepler
{
    if (!_DBhepler) {
        _DBhepler = [FMDatabase databaseWithPath:[self path]];
    }
    return _DBhepler;
}
/**  创建一张表 */
- (void)create
{
    [self.DBhepler open];
    //精华
    [self.DBhepler executeUpdate:@"CREATE TABLE IF NOT EXISTS TopicTableName (ID number,name text,profile_image text,create_time text,m_text text,ding number,cai number,repost number,comment number,sina_v number,width number,height number,small_image text,large_image text,middle_image text,type number,voicetime number,videotime number,playcount number,voiceuri text,videouri text,weixin_url text)"];
    //新帖
    [self.DBhepler executeUpdate:@"CREATE TABLE IF NOT EXISTS TopicModelTableName (ID number,name text,profile_image text,create_time text,m_text text,ding number,cai number,repost number,comment number,sina_v number,width number,height number,smallImage text,bigImage text,middleImage text,type number,longPicture number,voicetime number,videotime number,playcount number,voiceuri text,videouri text,progressTime number)"];
    
    [self.DBhepler close];
}
#pragma mark - 精华
/**  插入一个精华数据 */
- (void)insertTopic:(GHZTopic *)topic
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"insert into TopicTableName (ID,name,profile_image,create_time,m_text,ding,cai,repost,comment,sina_v,width,height,small_image,large_image,middle_image,type,voicetime,videotime,playcount,voiceuri,videouri,weixin_url) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",[NSNumber numberWithInteger:topic.ID],topic.name,topic.profile_image,topic.create_time,topic.text,[NSNumber numberWithInteger:topic.ding],[NSNumber numberWithInteger:topic.cai],[NSNumber numberWithInteger:topic.repost],[NSNumber numberWithInteger:topic.comment],[NSNumber numberWithBool:topic.sina_v],[NSNumber numberWithFloat:topic.width],[NSNumber numberWithFloat:topic.height],topic.small_image,topic.large_image,topic.middle_image,[NSNumber numberWithInteger:topic.type],[NSNumber numberWithInteger:topic.voicetime],[NSNumber numberWithInteger:topic.videotime],[NSNumber numberWithInteger:topic.playcount],topic.voiceuri,topic.videouri,topic.weixin_url];
    [self.DBhepler close];
    
}
/**  是否存在 */
- (BOOL)isExistsWithTopicID:(NSInteger)TopicID
{
    [self.DBhepler open];
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet*set = [self.DBhepler executeQuery:@"select * from TopicTableName where ID = ? ",[NSNumber numberWithInteger:TopicID]];
    while ([set next]) {
        GHZTopic *topic = [[GHZTopic alloc] init];
        topic.ID = TopicID;
        topic.name = [set stringForColumn:@"name"];
        topic.profile_image = [set stringForColumn:@"profile_image"];
        topic.create_time = [set stringForColumn:@"create_time"];
        topic.text = [set stringForColumn:@"m_text"];
        topic.ding = [set intForColumn:@"ding"];
        topic.cai = [set intForColumn:@"cai"];
        topic.repost = [set intForColumn:@"repost"];
        topic.comment = [set intForColumn:@"comment"];
        topic.sina_v = [set boolForColumn:@"sina_v"];
        topic.width = [set doubleForColumn:@"width"];
        topic.height = [set doubleForColumn:@"height"];
        topic.small_image = [set stringForColumn:@"small_image"];
        topic.large_image = [set stringForColumn:@"large_image"];
        topic.middle_image = [set stringForColumn:@"middle_image"];
        topic.type = [set intForColumn:@"type"];
        topic.voicetime = [set intForColumn:@"voicetime"];
        topic.videotime = [set intForColumn:@"videotime"];
        topic.playcount = [set intForColumn:@"playcount"];
        topic.voiceuri = [set stringForColumn:@"voiceuri"];
        topic.videouri = [set stringForColumn:@"videouri"];
        topic.weixin_url = [set stringForColumn:@"weixin_url"];
        [array addObject:topic];
    }
    [self.DBhepler close];
    if (array.count) {
        return YES;
    }else
    {
        return NO;
    }
}
/**  查找精华所有数据 */
- (NSMutableArray *)searchTopics
{
    [self.DBhepler open];
    FMResultSet*set = [self.DBhepler executeQuery:@"select * from TopicTableName"];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        GHZTopic *topic = [[GHZTopic alloc] init];
        topic.ID = [set intForColumn:@"ID"];
        topic.name = [set stringForColumn:@"name"];
        topic.profile_image = [set stringForColumn:@"profile_image"];
        topic.create_time = [set stringForColumn:@"create_time"];
        topic.text = [set stringForColumn:@"m_text"];
        topic.ding = [set intForColumn:@"ding"];
        topic.cai = [set intForColumn:@"cai"];
        topic.repost = [set intForColumn:@"repost"];
        topic.comment = [set intForColumn:@"comment"];
        topic.sina_v = [set boolForColumn:@"sina_v"];
        topic.width = [set doubleForColumn:@"width"];
        topic.height = [set doubleForColumn:@"height"];
        topic.small_image = [set stringForColumn:@"small_image"];
        topic.large_image = [set stringForColumn:@"large_image"];
        topic.middle_image = [set stringForColumn:@"middle_image"];
        topic.type = [set intForColumn:@"type"];
        topic.voicetime = [set intForColumn:@"voicetime"];
        topic.videotime = [set intForColumn:@"videotime"];
        topic.playcount = [set intForColumn:@"playcount"];
        topic.voiceuri = [set stringForColumn:@"voiceuri"];
        topic.videouri = [set stringForColumn:@"videouri"];
        topic.weixin_url = [set stringForColumn:@"weixin_url"];
        [array addObject:topic];
    }
    [self.DBhepler close];
    return array;
}
/**  删除精华某条数据 */
- (void)deleteTopicWithTopicID:(NSInteger)TopicID
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"delete from TopicTableName where ID = ? ",[NSNumber numberWithInteger:TopicID]];
    [self.DBhepler close];
}
#pragma mark - 新帖
/**  插入一个新帖数据 */
- (void)insertTopicModel:(GHZTopicModel *)topicModel
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"insert into TopicModelTableName (ID,name,profile_image,create_time,m_text,ding,cai,repost,comment,sina_v,width,height,smallImage,bigImage,middleImage,type,longPicture,voicetime,videotime,playcount,voiceuri,videouri,progressTime) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",[NSNumber numberWithInteger:topicModel.ID],topicModel.name,topicModel.profile_image,topicModel.create_time,topicModel.text,[NSNumber numberWithInteger:topicModel.ding],[NSNumber numberWithInteger:topicModel.cai],[NSNumber numberWithInteger:topicModel.repost],[NSNumber numberWithInteger:topicModel.comment],[NSNumber numberWithBool:topicModel.sina_v],[NSNumber numberWithFloat:topicModel.width],[NSNumber numberWithFloat:topicModel.height],topicModel.smallImage,topicModel.bigImage,topicModel.middleImage,[NSNumber numberWithInteger:topicModel.type],[NSNumber numberWithBool:topicModel.longPicture],[NSNumber numberWithInteger:topicModel.voicetime],[NSNumber numberWithInteger:topicModel.videotime],[NSNumber numberWithInteger:topicModel.playcount],topicModel.voiceuri,topicModel.videouri,[NSNumber numberWithFloat:topicModel.progressTime]];
    [self.DBhepler close];

}
/**  是否存在 */
- (BOOL)isExistsWithTopicModelID:(NSInteger)TopicModelID
{
    [self.DBhepler open];
    FMResultSet*set = [self.DBhepler executeQuery:@"select * from TopicModelTableName where ID = ? ",[NSNumber numberWithInteger:TopicModelID]];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        GHZTopicModel *topicModel = [[GHZTopicModel alloc] init];
        topicModel.ID = TopicModelID;
        topicModel.name = [set stringForColumn:@"name"];
        topicModel.profile_image = [set stringForColumn:@"profile_image"];
        topicModel.create_time = [set stringForColumn:@"create_time"];
        topicModel.text = [set stringForColumn:@"m_text"];
        topicModel.ding = [set intForColumn:@"ding"];
        topicModel.cai = [set intForColumn:@"cai"];
        topicModel.repost = [set intForColumn:@"repost"];
        topicModel.comment = [set intForColumn:@"comment"];
        topicModel.sina_v = [set boolForColumn:@"sina_v"];
        topicModel.width = [set doubleForColumn:@"width"];
        topicModel.height = [set doubleForColumn:@"height"];
        topicModel.smallImage = [set stringForColumn:@"smallImage"];
        topicModel.bigImage = [set stringForColumn:@"bigImage"];
        topicModel.middleImage = [set stringForColumn:@"middleImage"];
        topicModel.type = [set intForColumn:@"type"];
        topicModel.longPicture = [set boolForColumn:@"longPicture"];
        topicModel.voicetime = [set intForColumn:@"voicetime"];
        topicModel.videotime = [set intForColumn:@"videotime"];
        topicModel.playcount = [set intForColumn:@"playcount"];
        topicModel.voiceuri = [set stringForColumn:@"voiceuri"];
        topicModel.videouri = [set stringForColumn:@"videouri"];
        topicModel.progressTime = [set doubleForColumn:@"progressTime"];
        [array addObject:topicModel];
    }
    [self.DBhepler close];
    if (array.count) {
        return YES;
    }else
    {
        return NO;
    }
}
/**  查找新帖所有数据 */
- (NSMutableArray *)searchTopicModels
{
    [self.DBhepler open];
    FMResultSet*set = [self.DBhepler executeQuery:@"select * from TopicModelTableName"];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        GHZTopicModel *topicModel = [[GHZTopicModel alloc] init];
        topicModel.ID = [set intForColumn:@"ID"];
        topicModel.name = [set stringForColumn:@"name"];
        topicModel.profile_image = [set stringForColumn:@"profile_image"];
        topicModel.create_time = [set stringForColumn:@"create_time"];
        topicModel.text = [set stringForColumn:@"m_text"];
        topicModel.ding = [set intForColumn:@"ding"];
        topicModel.cai = [set intForColumn:@"cai"];
        topicModel.repost = [set intForColumn:@"repost"];
        topicModel.comment = [set intForColumn:@"comment"];
        topicModel.sina_v = [set boolForColumn:@"sina_v"];
        topicModel.width = [set doubleForColumn:@"width"];
        topicModel.height = [set doubleForColumn:@"height"];
        topicModel.smallImage = [set stringForColumn:@"smallImage"];
        topicModel.bigImage = [set stringForColumn:@"bigImage"];
        topicModel.middleImage = [set stringForColumn:@"middleImage"];
        topicModel.type = [set intForColumn:@"type"];
        topicModel.longPicture = [set boolForColumn:@"longPicture"];
        topicModel.voicetime = [set intForColumn:@"voicetime"];
        topicModel.videotime = [set intForColumn:@"videotime"];
        topicModel.playcount = [set intForColumn:@"playcount"];
        topicModel.voiceuri = [set stringForColumn:@"voiceuri"];
        topicModel.videouri = [set stringForColumn:@"videouri"];
         topicModel.progressTime = [set doubleForColumn:@"progressTime"];
        [array addObject:topicModel];
    }
    [self.DBhepler close];
    return array;
}
/**  删除新帖某条数据 */
- (void)deleteTopicModelWithTopicModelID:(NSInteger)TopicModelID
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"delete from TopicModelTableName where ID = ? ",TopicModelID];
    [self.DBhepler close];
}
@end
