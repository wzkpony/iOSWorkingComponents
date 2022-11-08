//
//  HSPhotoImgItemCell.m
//  HSiOS
//
//  Created by wzk on 2021/11/12.
//

#import "HSPhotoImgItemCell.h"

@implementation HSPhotoImgItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.numLabel configCornerRadius:self.numLabel.jk_height/2.0];
}

@end
