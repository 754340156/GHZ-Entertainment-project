//
//  GHZTopicController.h
//  GHZxiangmuB
//
//  Created by    on 16/7/12.
//  Copyright © 2016年  赵哲. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>

@class GHZTopic;

@interface GHZTopicController : UITableViewController

/**帖子类型(交给子类去实现)*/
@property(nonatomic,assign)  GHZTopicType type;

@property (nonatomic, strong) GHZTopic *topic;

@end
