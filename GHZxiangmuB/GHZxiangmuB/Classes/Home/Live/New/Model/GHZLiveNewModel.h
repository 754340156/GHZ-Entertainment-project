//
//  GHZLiveNewModel.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GHZLiveNewModel : NSObject

@property (nonatomic, assign) NSInteger shortidx;
/** 主播名 */
@property (nonatomic, copy) NSString *myname;
/** 小图 */
@property (nonatomic, copy) NSString *smallpic;
/** 直播流 */
@property (nonatomic, copy) NSString *flv;
/** 所在服务器号 */
@property (nonatomic, assign) NSInteger serverid;
/** 房间号 */
@property (nonatomic, assign) NSInteger roomid;
/** 所在城市 */
@property (nonatomic, copy) NSString *gps;
/** 星等 */
@property (nonatomic, assign) NSInteger starlevel;
/** 主播帐号名 */
@property (nonatomic, copy) NSString *userId;
/** 个性签名 */
@property (nonatomic, copy) NSString *signatures;
/** 大图 */
@property (nonatomic, copy) NSString *bigpic;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger curexp;
/** 主播ID */
@property (nonatomic, assign) NSInteger useridx;

@property (nonatomic, assign) NSInteger grade;

@property (nonatomic, assign) NSInteger gender;
/** 在线人数 */
@property (nonatomic, assign) NSInteger allnum;

@end


@interface GHZLiveNewSCVModel : NSObject
/** 新增时间 */
@property (nonatomic, copy  ) NSString   *addTime;
/** AD图片 */
@property (nonatomic, copy  ) NSString   *imageUrl;
/** AD名 */
@property (nonatomic, copy  ) NSString   *title;
/** 倒计时 */
@property (nonatomic, assign) NSUInteger cutTime;
/** 链接 */
@property (nonatomic, copy  ) NSString   *link;
/** AD序号 */
@property (nonatomic, assign) NSUInteger orderid;
@end
