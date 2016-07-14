//
//  GHZNewVideoView.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewVideoView.h"
#import "GHZTopicModel.h"
#import "UIImageView+WebCache.h"
#import "XLVideoPlayer.h"

@interface GHZNewVideoView ()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,assign)CGRect c;
@property (nonatomic,copy)NSString *url;

@end

@implementation GHZNewVideoView

+(instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideo)]];
}
-(void)setModel:(GHZTopicModel *)model{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImage]];
    
    self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放",  model.playcount];
    
    //时长
    NSInteger f = model.videotime/60;
    NSInteger m = model.videotime%60;
    self.videotimeLabel.text = [NSString stringWithFormat:@"%.02ld:%.02ld",f,m];
    self.c = model.videoViewFrame;
    self.url = model.videouri;
}

-(IBAction)showVideo{
   
//    
//    if (self.click) {
//        self.click(sender);
//    }
//    
//    if (self.delegate && [self respondsToSelector:@selector(clickWithbutton:)])
//    {
//        [self.delegate clickWithbutton:sender];
//    }
    
    self.player = [[XLVideoPlayer alloc] init];
    self.player.videoUrl = self.model.videouri;
    self.player.frame = CGRectMake(0, 0, self.model.videoViewFrame.size.width, self.model.self.height);
    [self addSubview:self.player];
}

- (IBAction)VideoButton:(UIButton *)sender {
    NSLog(@"1");
    if (self.delegate && [self respondsToSelector:@selector(clickWithbutton:)]) {
        [self.delegate clickWithbutton:sender];
    }
    
    
}


@end
