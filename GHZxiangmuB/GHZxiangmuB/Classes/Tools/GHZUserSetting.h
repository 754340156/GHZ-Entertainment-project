//
//  GHZUserSetting.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHZUserSetting : NSObject
/**  userName */
@property (nonatomic,copy) NSString *userName;
/**  nickName*/
@property (nonatomic,copy) NSString *nickName;

+ (instancetype)shareInstance;
@end
