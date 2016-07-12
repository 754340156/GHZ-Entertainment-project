//
//  GHZTopicController.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>

typedef enum {

    GHZTopicType1All = 1,
    GHZTopicType1Picture = 10,
    GHZTopicType1Word = 29,
    GHZTopicType1Voice = 31,
    GHZTopicType1Video = 41

} GHZTopicType1;


@interface GHZTopicController : UITableViewController

/**帖子类型(交给子类去实现的)*/
@property(nonatomic,assign) GHZTopicType type;

@end
