//
//  GHZFileDataHandle.h
//  GHZxiangmuB
//
//  Created by    on 16/7/15.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHZFileDataHandle : NSObject


+ (instancetype)shareInstance;
/**  计算缓存 */
- (CGFloat)getDiskSize;
/**  清除缓存 */
- (void)clearDisk;
@end
