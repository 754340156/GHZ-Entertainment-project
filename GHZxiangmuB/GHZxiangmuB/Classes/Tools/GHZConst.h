
#import <UIKit/UIKit.h>

typedef enum {
    /**所有*/
    All = 1,
    /**图片*/
    Picture = 10,
    /**段子*/
    Word = 29,
    /**声音*/
    Music = 31,
    /**视频*/
    Video = 41
    
}GHZTopicType;


//标签的高和Y
UIKIT_EXTERN CGFloat const GHZTitleVH;
UIKIT_EXTERN CGFloat const GHZTitleVY;
/**cell之间的空隙*/
UIKIT_EXTERN CGFloat const GHZCellmargin;
/**text的x值*/
UIKIT_EXTERN CGFloat const GHZCellTextX;
/**文字的Y*/
UIKIT_EXTERN CGFloat const GHZCellTextY;
/**底部点赞栏的高度*/
UIKIT_EXTERN CGFloat const GHZCelltoolH;
/**图片cell最高值*/
UIKIT_EXTERN CGFloat const GHZCellPictureMaxH;
/**图片高度超出规定的参数*/
UIKIT_EXTERN CGFloat const GHZCellPictureBreakH;


