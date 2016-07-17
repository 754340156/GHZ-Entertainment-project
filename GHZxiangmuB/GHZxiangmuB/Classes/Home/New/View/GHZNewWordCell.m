//
//  GHZNewWordCell.m
//  GHZxiangmuB
//
//  Created by lanou3g on 16/7/9.
//  Copyright © 2016年 lanou3g-22赵哲. All rights reserved.
//

#import "GHZNewWordCell.h"
#import "GHZTopicModel.h"
#import "GHZNewPictureView.h"
#import "UIImageView+WebCache.h"
#import "GHZNewMusicView.h"
#import "GHZDataBaseHelper.h"
#import "UIImage+Extension.h"
@interface GHZNewWordCell ()
/** 头像*/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶*/
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩*/
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享*/
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论*/
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
/** 新浪用户V*/
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/**文本内容*/
@property (weak, nonatomic) IBOutlet UILabel *TextsLabel;
/**图片中间的view*/
@property (nonatomic,weak)GHZNewPictureView *pictureView;
/**音乐播放界面*/
@property (nonatomic,weak)GHZNewMusicView *musicView;
/**视频播放界面*/
@property (nonatomic,weak)GHZNewVideoView *videoView;
@end

@implementation GHZNewWordCell
-(GHZNewPictureView *)pictureView{
    if (!_pictureView) {
        GHZNewPictureView *pictureView = [GHZNewPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

-(GHZNewMusicView *)musicView{
    if (!_musicView) {
        GHZNewMusicView *musicView = [GHZNewMusicView MusicView];
        [self.contentView addSubview:musicView];
        _musicView = musicView;
    }
    return _musicView;
}
-(GHZNewVideoView *)videoView{
    if (!_videoView) {
        GHZNewVideoView* videoView = [GHZNewVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

// 从队列里面复用时调用
- (void)prepareForReuse
{
    [super prepareForReuse];
    [_musicView reset];
    [_videoView reset];
}
-(void)awakeFromNib{
    UIImageView *bjView = [[UIImageView alloc] init];
    bjView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bjView;
}
-(void)setModel:(GHZTopicModel *)model{
    _model = model;
//页面参数
    //新浪V
    self.sinaVView.hidden = !model.sina_v;
    //头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.profileImageView.image = image ? [UIImage circleImage:image borderColor:nil borderWidth:0] : [UIImage circleImage:[UIImage imageNamed:@"defaultUserIcon"] borderColor:nil borderWidth:0];
    }];
    //昵称
    self.nameLabel.text = model.name;
    //设置时间
    self.createTimeLabel.text = model.create_time;
//按钮参数
    [self ButtonTitle:self.dingButton count:model.ding placeholder:@"顶"];
    [self ButtonTitle:self.caiButton count:model.cai placeholder:@"踩"];
    [self ButtonTitle:self.shareButton count:model.repost placeholder:@"分享"];
    [self ButtonTitle:self.commentsButton count:model.comment placeholder:@"评论"];
    self.TextsLabel.text = model.text;
    if (model.type == Picture) { //根据类型把相应的view贴到view上
        self.pictureView.hidden = NO;
        self.pictureView.model = model;
        self.pictureView.frame = model.pictureViewFrame;
        self.musicView.hidden = YES;
        self.videoView.hidden =YES;
    }if (model.type == Music) { //音乐
        self.musicView.hidden = NO;
        self.musicView.model = model;
        self.musicView.frame = model.musicViewFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;

    }if (model.type ==Video) {
        self.videoView.hidden = NO;
        self.videoView.model = model;
        self.videoView.frame = model.videoViewFrame;
        self.pictureView.hidden = YES;
        self.musicView.hidden = YES;
    }if (model.type ==Word) {
        self.pictureView.hidden = YES;
        self.musicView.hidden = YES;
        self.videoView.hidden = YES;
    }
}
-(void)testDate:(NSString *)create_time
{
        //当前时间
        NSDate *now = [NSDate date];
        //发帖时间
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        //设置日期格式      年   月 日  时 分 秒
        f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *create = [f dateFromString:create_time];
        [now timeIntervalSinceDate:create];
        [now deltaFrom:create];
}
//按钮参数格式
-(void)ButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
   // NSString *title = nil;
     //大于一万之后 参数格式
    if (count>10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else  if(count>0){
        placeholder = [NSString stringWithFormat:@"%ld",count];
    }
    [button setTitle:placeholder forState:(UIControlStateNormal)];
}
-(void)setFrame:(CGRect)frame{
    frame.origin.x = 3 ;
    frame.size.width-= 2 * 3;
    frame.size.height -= GHZCellmargin;
    frame.origin.y += GHZCellmargin;
    [super setFrame:frame];
}
//点击分享按钮
- (IBAction)shareButtonClick:(id)sender {
    NSString *url = [[NSString alloc] init];
    if (self.model.type ==Video) {
        url = self.model.videouri;
    }else if(self.model.type ==Music){
        url = self.model.voiceuri;
    }else if (self.model.type ==Picture){
        url = self.model.bigImage;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(getclick:url:text:)]) {
        [self.delegate getclick:self.model.bigImage url:url text:self.model.text];
    }
}
- (IBAction)commentClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getClickCommentWithModel:)]) {
        [self.delegate getClickCommentWithModel:self.model];
    }
}
//点击收藏按钮
- (IBAction)collectionBtn:(id)sender {
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle: nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];//创建界面
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]; //创建按钮cancel以及对应事件
    UIAlertAction *saveAction=[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[GHZDataBaseHelper shareInstance] create];
        [[GHZDataBaseHelper shareInstance]insertTopicModel:self.model];
    }];//创建按钮ok以及对应事件
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //最后将这些按钮都添加到界面上去，显示界面
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    [alertController addAction:report];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: alertController animated:YES completion:nil];
}


@end
