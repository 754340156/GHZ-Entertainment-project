//
//  GHZTopicModel.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GHZTopicModel : NSObject
/** 名称*/ 
@property (nonatomic,strong)NSString *name;
/** 头像*/
@property (nonatomic,strong)NSString *profile_image;
/** 发帖时间*/
@property (nonatomic,strong)NSString *create_time;
/** 文字*/
@property (nonatomic,strong)NSString *text;
/**顶 */
@property (nonatomic,assign)NSInteger ding;
/**踩 */
@property (nonatomic,assign)NSInteger cai;
/**转发 */
@property (nonatomic,assign)NSInteger repost;
/**评论 */
@property (nonatomic,assign)NSInteger comment;
/**是否新浪V */
@property (nonatomic,assign,getter=isSina_V) BOOL sina_v;
/**图片宽度*/
@property (nonatomic,assign)CGFloat width;
/**图片高度*/
@property (nonatomic,assign)CGFloat height;
/**小图片的路径*/
@property (nonatomic,copy)NSString *smallImage;
/**大图片的路径*/
@property (nonatomic,copy)NSString *bigImage;
/**中图片的路径*/
@property (nonatomic,copy)NSString *middleImage;
/**cell高度*/
@property (nonatomic,assign,readonly)CGFloat cellHeight;
/**类型*/
@property (nonatomic,assign)GHZTopicType type;
/**图片的frame*/
@property (nonatomic,assign,readonly)CGRect pictureViewFrame;
/**声音控件frame*/
@property (nonatomic,assign,readonly)CGRect musicViewFrame;
/**视频控件frame*/
@property (nonatomic,assign,readonly)CGRect videoViewFrame;
/**图片是否为长图*/
@property (nonatomic,assign,getter=longPicture)BOOL longPicture;
/**音频时长*/
@property (nonatomic,assign)NSInteger voicetime;
/**视频时长*/
@property (nonatomic,assign)NSInteger videotime;
/**播放次数*/
@property (nonatomic,assign)NSInteger playcount;
@property (nonatomic,copy)NSString *voiceuri;
@property (nonatomic,copy)NSString *videouri;
@property (nonatomic,assign)CGFloat progressTime;
@end