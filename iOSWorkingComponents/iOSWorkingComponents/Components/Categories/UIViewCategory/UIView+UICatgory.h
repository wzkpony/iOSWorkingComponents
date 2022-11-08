//
//  UIView+UICatgory.h
//  lockiOS
//
//  Created by wzk on 2019/10/14.
//  Copyright © 2019 wzk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (UICatgory)
//配置button的样式:8厘米拐角半径。和字体颜色的边框
+ (void)viewBorderAndCornerConfig:(UIButton *)button;
//圆形 和边框
- (void)viewBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor isWidth:(BOOL)isWidth;

//设置拐角半径
- (void)configCornerRadius:(CGFloat )cornerRadius;

- (void)configCornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**设置阴影*/
- (void)shadow;

/**设置阴影*/
- (void)shadowOpacity:(CGFloat)opacity withSize:(CGSize)size withColor:(UIColor *)color;


- (void)verticalStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

///
- (void)verticalStartColor:(UIColor *)startColor endColor:(UIColor *)endColor endPoint:(CGFloat)endPoint;

- (void)crosswiseStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

///横向渐变自定义宽度
- (void)crosswiseWidth:(CGFloat)width StartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

///横向渐变自定义宽度 类型
- (void)crosswiseWidth:(CGFloat)width StartColor:(UIColor *)startColor endColor:(UIColor *)endColor layerType:(CAGradientLayerType)type;
///横向渐变
- (void)crosswiseStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

- (void)crosswiseLeftToRightStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;
@end

NS_ASSUME_NONNULL_END
