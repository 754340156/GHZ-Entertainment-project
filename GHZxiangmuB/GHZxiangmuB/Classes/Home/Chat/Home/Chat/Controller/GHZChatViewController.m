//
//  GHZChatViewController.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZChatViewController.h"

@interface GHZChatViewController ()<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>

@end

@implementation GHZChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
}

/*!
 @method
 @brief 获取消息自定义cell
 @discussion 用户根据messageModel判断是否显示自定义cell。返回nil显示默认cell，否则显示用户自定义cell
 @param tableView 当前消息视图的tableView
 @param messageModel 消息模型
 @result 返回用户自定义cell
 */
- (UITableViewCell *)messageViewController:(UITableView *)tableView
                       cellForMessageModel:(id<IMessageModel>)messageModel
{
    return nil;
}

/*!
 @method
 @brief 获取消息cell高度
 @discussion 用户根据messageModel判断，是否自定义显示cell的高度
 @param viewController 当前消息视图
 @param messageModel 消息模型
 @param cellWidth 视图宽度
 @result 返回用户自定义cell
 */
- (CGFloat)messageViewController:(EaseMessageViewController *)viewController
           heightForMessageModel:(id<IMessageModel>)messageModel
                   withCellWidth:(CGFloat)cellWidth
{
    return 0;
}
/*!
 @method
 @brief 选中消息的回调
 @discussion 用户根据messageModel判断，是否自定义处理消息选中时间。返回YES为自定义处理，返回NO为默认处理
 @param viewController 当前消息视图
 @param messageModel 消息模型
 @result 是否采用自定义处理
 */
- (BOOL)messageViewController:(EaseMessageViewController *)viewController
        didSelectMessageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    //样例为如果消息是文件消息用户自定义处理选中逻辑
    switch (messageModel.bodyType) {
        case EMMessageBodyTypeImage:
        case EMMessageBodyTypeLocation:
        case EMMessageBodyTypeVideo:
        case EMMessageBodyTypeVoice:
            break;
        case EMMessageBodyTypeFile:
        {
            flag = YES;
            NSLog(@"用户自定义实现");
        }
            break;
        default:
            break;
    }
    return flag;
}

@end
