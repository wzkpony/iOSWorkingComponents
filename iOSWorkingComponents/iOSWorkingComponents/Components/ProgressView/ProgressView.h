//
//  ProgressView.h
//  HSiOS
//
//  Created by wzk on 2021/12/8.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgressView : BaseView

@property (strong ,nonatomic) UIColor *backViewColor;
@property (strong ,nonatomic) UIColor *progressColor;

@property (assign ,nonatomic) CGFloat progress;
@end

NS_ASSUME_NONNULL_END
