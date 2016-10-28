//
//  GHZChatViewController.m
//  GHZxiangmuB
//
//  Created by    on 16/7/12.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZChatViewController.h"

@interface GHZChatViewController ()<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>

@end

@implementation GHZChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = self.conversation.conversationId;
    self.delegate = self;
    self.dataSource = self;
}

//选中消息回调的样例：
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
//录音按钮状态的回调样例：
- (void)messageViewController:(EaseMessageViewController *)viewController
          didSelectRecordView:(UIView *)recordView
                 withEvenType:(EaseRecordViewType)type
{
    /*
     EaseRecordViewTypeTouchDown,//录音按钮按下
     EaseRecordViewTypeTouchUpInside,//手指在录音按钮内部时离开
     EaseRecordViewTypeTouchUpOutside,//手指在录音按钮外部时离开
     EaseRecordViewTypeDragInside,//手指移动到录音按钮内部
     EaseRecordViewTypeDragOutside,//手指移动到录音按钮外部
     */
    //根据type类型，用户自定义处理UI的逻辑
    switch (type) {
        case EaseRecordViewTypeTouchDown:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView  recordButtonTouchDown];
            }
        }
            break;
        case EaseRecordViewTypeTouchUpInside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonTouchUpInside];
            }
            [self.recordView removeFromSuperview];
        }
            break;
        case EaseRecordViewTypeTouchUpOutside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonTouchUpOutside];
            }
            [self.recordView removeFromSuperview];
        }
            break;
        case EaseRecordViewTypeDragInside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonDragInside];
            }
        }
            break;
        case EaseRecordViewTypeDragOutside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonDragOutside];
            }
        }
            break;
        default:
            break;
    }
}
//长按收拾回调样例：
- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    //样例给出的逻辑是所有cell都允许长按
    return YES;
}
@end
