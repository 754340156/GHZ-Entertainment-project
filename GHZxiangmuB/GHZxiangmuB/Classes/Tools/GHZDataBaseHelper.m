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
        [self.DBhepler executeUpdate:@"CREATE TABLE IF NOT EXISTS TopicTableName (name text,profile_image text,create_time text,m_text text,ding integer,cai integer,repost integer,comment integer,sina_v none,width real,height real,small_image text,large_image text,middle_image text,type integer,voicetime integer,videotime integer,playcount integer,voiceuri text,videouri text,weixin_url text)"];
    //新帖
    [self.DBhepler executeUpdate:@"CREATE TABLE IF NOT EXISTS TopicModelTableName (name text,profile_image text,create_time text,m_text text,ding integer,cai integer,repost integer,comment integer,sina_v none,width real,height real,smallImage text,bigImage text,middleImage text,type integer,longPicture none,voicetime integer,videotime integer,playcount integer,voiceuri text,videouri text,progressTime real)"];
    
    [self.DBhepler close];
}
#pragma mark - 精华
/**  插入一个精华数据 */
- (void)insertTopic:(GHZTopic *)topic
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"insert into TopicTableName (name,profile_image,create_time,m_text,ding,cai,repost,comment,sina_v,width,height,small_image,large_image,middle_image,type,voicetime,videotime,playcount,voiceuri,videouri,weixin_url) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",topic.name,topic.profile_image,topic.create_time,topic.text,topic.ding,topic.cai,topic.repost,topic.comment,topic.sina_v,topic.width,topic.height,topic.small_image,topic.large_image,topic.middle_image,(NSInteger)topic.type,topic.voicetime,topic.videotime,topic.playcount,topic.voiceuri,topic.videouri,topic.weixin_url];
    [self.DBhepler close];
    
}
/**  查找精华所有数据 */
- (NSMutableArray *)searchTopics
{
    [self.DBhepler open];
    FMResultSet*set = [self.DBhepler executeQuery:@"select * from TopicTableName"];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        GHZTopic *topic = [[GHZTopic alloc] init];
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
- (void)deleteTopicWithcreate_time:(NSString *)create_time
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"delete from TopicTableName where create_time = ? ",create_time];
    [self.DBhepler close];
}
#pragma mark - 新帖
/**  插入一个新帖数据 */
- (void)insertTopicModel:(GHZTopicModel *)topicModel
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"insert into TopicModelTableName (name,profile_image,create_time,m_text,ding,cai,repost,comment,sina_v,width,height,smallImage,bigImage,middleImage,type,longPicture,voicetime,videotime,playcount,voiceuri,videouri,progressTime) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",topicModel.name,topicModel.profile_image,topicModel.create_time,topicModel.text,topicModel.ding,topicModel.cai,topicModel.repost,topicModel.comment,topicModel.sina_v,topicModel.width,topicModel.height,topicModel.smallImage,topicModel.bigImage,topicModel.middleImage,(NSInteger)topicModel.type,topicModel.longPicture,topicModel.voicetime,topicModel.videotime,topicModel.playcount,topicModel.voiceuri,topicModel.videouri,topicModel.progressTime];
    [self.DBhepler close];

}
/**  查找新帖所有数据 */
- (NSMutableArray *)searchTopicModels
{
    [self.DBhepler open];
    FMResultSet*set = [self.DBhepler executeQuery:@"select * from TopicModelTableName"];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        GHZTopicModel *topicModel = [[GHZTopicModel alloc] init];
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
- (void)deleteTopicModelWithcreate_time:(NSString *)create_time
{
    [self.DBhepler open];
    [self.DBhepler executeUpdate:@"delete from TopicModelTableName where create_time = ? ",create_time];
    [self.DBhepler close];
}
@end
