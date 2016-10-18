//
//  GHZNewMusicView.h
//  GHZxiangmuB
//
//  Created by    on 16/7/12.
//  Copyright © 2016年  赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHZTopicModel;
@interface GHZNewMusicView : UIView
+(instancetype)MusicView;
@property (nonatomic,strong)GHZTopicModel *model;
-(void)reset;
@end
