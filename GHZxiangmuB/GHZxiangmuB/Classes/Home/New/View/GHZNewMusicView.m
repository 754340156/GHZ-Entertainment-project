//
//  GHZNewMusicView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewMusicView.h"
#import "GHZTopicModel.h"
#import "UIImageView+WebCache.h"
@interface GHZNewMusicView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicelengthLabel;

@end


@implementation GHZNewMusicView

+(instancetype)MusicView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;

}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}
-(void)setModel:(GHZTopicModel *)model{
    _model =  model;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage]];
    //播放资源
    self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放",model.playcount];
//    NSInteger str = [model.voicetime intValue];
    NSInteger f = model.voicetime/60;
    NSInteger m = model.voicetime%60;
    self.voicelengthLabel.text = [NSString stringWithFormat:@"%.02ld:%.02ld",f,m];
}


@end
