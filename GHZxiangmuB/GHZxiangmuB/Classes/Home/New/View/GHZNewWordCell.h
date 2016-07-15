//
//  GHZNewWordCell.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopicModel;



@protocol GHZNewWordCellDelegate <NSObject>

- (void)click:(NSString *)viedourl width:(NSInteger)width height:(NSInteger)height btn:(UIButton *)btn;
-(void)getclick:(NSString *)image url:(NSString *)url text:(NSString *)text;

@end
@interface GHZNewWordCell : UITableViewCell
/** 段子model*/
@property (nonatomic,strong)GHZTopicModel *model;

@property (nonatomic,weak)id <GHZNewWordCellDelegate>delegate;
@end
