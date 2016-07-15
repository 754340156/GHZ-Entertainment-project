//
//  GHZShowPictureViewController.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopic;

@protocol GHZShowPictureViewController <NSObject>

- (void)getClick:(NSString *)image url:(NSString *)url text:(NSString *)text;

@end


@interface GHZShowPictureViewController : UIViewController
/**帖子*/
@property(nonatomic, strong)  GHZTopic *topic;

@property (nonatomic, weak) id <GHZShowPictureViewController> delegate;

@end
