//
//  HSPhotoImgItemCell.h
//  HSiOS
//
//  Created by wzk on 2021/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSPhotoImgItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *numBGView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

@end

NS_ASSUME_NONNULL_END
