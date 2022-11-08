//
//  PHPhotoView.h
//  HSiOS
//
//  Created by wzk on 2021/11/12.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PHPhotoView : BaseView

@property (weak, nonatomic) IBOutlet UIImageView *arrowsImg;


@property (copy ,nonatomic) void (^selectCancelBlock)(void);
@property (copy ,nonatomic) void (^selectOKBlock)(void);

@property (copy ,nonatomic) void (^selectItemNumLabelBlock)(PHAsset *asset,PHPhotoView *photoView,NSInteger row);



- (void)reloadSelectUI:(NSMutableArray *)selectArr currentPage:(NSInteger)page allCount:(NSInteger)allCount;

@end

NS_ASSUME_NONNULL_END
