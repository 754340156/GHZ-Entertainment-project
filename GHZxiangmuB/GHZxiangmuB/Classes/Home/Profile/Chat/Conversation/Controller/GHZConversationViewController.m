//
//  GHZConversationViewController.m
//  GHZxiangmuB
//
//  Created by    on 16/7/12.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import "GHZConversationViewController.h"
#import "GHZChatViewController.h"
@interface GHZConversationViewController ()<EaseConversationListViewControllerDataSource,EaseConversationListViewControllerDelegate,EMChatManagerDelegate>

@end

@implementation GHZConversationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self tableViewDidTriggerHeaderRefresh];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [self refreshAndSortView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.delegate = self;
    self.dataSource = self;

}
#pragma mark - EaseConversationListViewControllerDelegate
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    GHZChatViewController *chatVC = [[GHZChatViewController alloc] initWithConversationChatter:conversationModel .title conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:chatVC animated:YES];
}
#pragma mark  - EaseConversationListViewControllerDataSource
//最后一条消息展示内容样例
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"[图片]", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    latestMessageTitle = @"[动画表情]";
                }
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"[语音]", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"[位置]", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"[视频]", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"[文件]", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    return latestMessageTitle;
}
//最后一条消息展示时间
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    return latestMessageTime;
}
#pragma mark -EMChatManagerDelegate

- (void)didReceiveMessages:(NSArray *)aMessages;
{
     [self tableViewDidTriggerHeaderRefresh];
     [self refreshAndSortView];
}
@end
