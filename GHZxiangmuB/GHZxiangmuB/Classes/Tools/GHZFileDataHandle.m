//
//  GHZFileDataHandle.m
//  GHZxiangmuB
//
//  Created by    on 16/7/15.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZFileDataHandle.h"

@implementation GHZFileDataHandle
static GHZFileDataHandle *instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GHZFileDataHandle alloc] init];
    });
    return instance;
}
/**  计算缓存 */
- (CGFloat)getDiskSize
{
    NSInteger size = 0;
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *mgr = [NSFileManager defaultManager];
    //获取到lib下面所有的子路径
    NSArray *libSubpaths = [mgr subpathsAtPath:libPath];
    for ( NSString *str in libSubpaths) {
        if (![str containsString:@"Preferences"]) {
            //拼接成完整路径
            NSString *path  =[libPath stringByAppendingPathComponent:str];
            //获取文件的属性
            NSDictionary *strAttr = [mgr attributesOfItemAtPath:path error:nil];
            //得到文件的大小
            size  = size +[strAttr[@"NSFileSize"] integerValue];
        }
    }
    return size / 1024.0 / 1024.0 ;
}
/**  清除缓存 */
- (void)clearDisk
{
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *mgr = [NSFileManager defaultManager];
    //获取到lib下面所有的子路径
    NSArray *libSubpaths = [mgr subpathsAtPath:libPath];
    for ( NSString *str in libSubpaths) {
        if (![str containsString:@"Preferences"]) {
            //拼接成完整路径
            NSString *path  =[libPath stringByAppendingPathComponent:str];
            [mgr removeItemAtPath:path error:nil];
        }
    }
}
@end
