//
//  GHZHotModel.h
//  GHZxiangmuB
//
//  Created by    on 16/7/8.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GHZHotModel : NSObject
/** 在线人数 */
@property (nonatomic, assign) NSInteger allnum;
/** 房间号 */
@property (nonatomic, assign) NSInteger roomid;
/** 星等 */
@property (nonatomic, assign) NSInteger starlevel;
/** 主播名字 */
@property (nonatomic, copy) NSString *nickname;
/** 主播ID */
@property (nonatomic, assign) NSInteger useridx;
/** 所在城市 */
@property (nonatomic, copy) NSString *position;
/** 所在服务器号 */
@property (nonatomic, assign) NSInteger serverid;
/** 图片 */
@property (nonatomic, copy) NSString *photo;
/** 性别 */
@property (nonatomic, assign) NSInteger sex;
/** 直播流 */
@property (nonatomic, copy) NSString *flv;
/** 是否是新用户 */
@property (nonatomic, assign) NSInteger new;

@end

