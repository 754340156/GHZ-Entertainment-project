//
//  GHZTopic.h
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/11.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHZTopic : NSObject

/**名称*/
@property(nonatomic,copy)  NSString *name;

/**头像*/
@property(nonatomic,copy)  NSString *profile_image;

/**发帖时间*/
@property(nonatomic,copy)  NSString *create_time;

/**文字内容*/
@property(nonatomic,copy)  NSString *text;

/**顶的数量*/
@property(nonatomic,assign)  NSInteger ding;

/**踩的数量*/
@property(nonatomic,assign)  NSInteger cai;

/**转发的数量*/
@property(nonatomic,assign)  NSInteger repost;

/**评论的数量*/
@property(nonatomic,assign)  NSInteger comment;

/**是否为新浪加 V 用户*/
@property(nonatomic,assign, getter=isSina_v) BOOL sina_v;
/**图片的宽度*/
@property(nonatomic,assign)  CGFloat width;
/**图片的高度*/
@property(nonatomic,assign)  CGFloat height;
/**小图片的 URL*/
@property(nonatomic,copy) NSString *small_image;
/**大图片的 URL*/
@property(nonatomic,copy) NSString *large_image;
/**中图片的 URL*/
@property(nonatomic,copy) NSString *middle_image;
/**帖子的类型*/
@property(nonatomic,assign) GHZTopicType type;
/**音频时长*/
@property(nonatomic,assign)  NSInteger voicetime;
/**播放次数*/
@property(nonatomic,assign) NSInteger playcount;
/**视频时长*/
@property(nonatomic,assign)  NSInteger videotime;
/**音频的 URL*/
@property(nonatomic,copy) NSString *voiceuri;



/*****额外的辅助属性*****/
/**cell的高度*/
@property(nonatomic,assign, readonly) CGFloat cellHeight;
/**图片控件的 frame*/
@property(nonatomic,assign, readonly) CGRect pictureF;
/**图片是否太大*/
@property(nonatomic,assign, getter = isBigPicture) BOOL bigPicture;
/**图片的下载进度*/
@property(nonatomic,assign)  CGFloat pictureProgress;
/**声音控件的 frame*/
@property(nonatomic,assign, readonly) CGRect  voiceF;    
/**视频控件的 frame*/
@property(nonatomic,assign, readonly) CGRect  videoF;
@end
