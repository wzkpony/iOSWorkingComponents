//
//  UIView+UICatgory.m
//  lockiOS
//
//  Created by wzk on 2019/10/14.
//  Copyright © 2019 wzk. All rights reserved.
//

#import "UIView+UICatgory.h"
#import <JKCategories/JKCategories.h>
#import "ColorConfig.h"

@implementation UIView (UICatgory)
//配置button的样式:8厘米拐角半径。和字体颜色的边框
+ (void)viewBorderAndCornerConfig:(UIButton *)button{
    button.clipsToBounds = YES;
    button.layer.borderColor = button.currentTitleColor.CGColor;
    button.layer.cornerRadius = 8;
    button.layer.borderWidth = 1;
}

//圆形 和边框
- (void)viewBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor isWidth:(BOOL)isWidth{
    self.clipsToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    if (isWidth) {
        self.layer.cornerRadius = (self.jk_width/2.0);
    }
    else{
        self.layer.cornerRadius = (self.jk_height/2.0);
    }
    self.layer.borderWidth = borderWidth;
}

//配置拐角半径
- (void)configCornerRadius:(CGFloat )cornerRadius{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
//配置拐角半径和边框
- (void)configCornerRadius:(CGFloat )cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}
/**设置阴影*/
- (void)shadow{
    self.layer.shadowOffset = CGSizeMake(0, -1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = App_UICOLOR_HEX(@"#999999").CGColor;
}

/**设置阴影*/
- (void)shadowOpacity:(CGFloat)opacity withSize:(CGSize)size withColor:(UIColor *)color{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowColor = color.CGColor;
   
}

///竖向渐变
- (void)verticalStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
//    gradientLayer.locations = @[@(0.2),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, self.jk_width, self.jk_height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

///竖向渐变
- (void)verticalStartColor:(UIColor *)startColor endColor:(UIColor *)endColor endPoint:(CGFloat)endPoint {
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.2),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, endPoint);
    gradientLayer.frame = CGRectMake(0, 0, self.jk_width, self.jk_height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


///横向渐变
- (void)crosswiseStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    if (self.layer.sublayers.count > 0) {
        NSMutableArray *layers = [NSMutableArray arrayWithArray:self.layer.sublayers];
        for (CALayer *obj in layers) {
            if ([obj isKindOfClass:[CAGradientLayer class]]) {
                [obj removeFromSuperlayer];
            }
        }
       
    }
    
    if (startColor == nil || endColor == nil) {
        return;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.2),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, self.jk_width, self.jk_height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

///横向渐变
- (void)crosswiseLeftToRightStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    if (self.layer.sublayers.count > 0) {
        NSMutableArray *layers = [NSMutableArray arrayWithArray:self.layer.sublayers];
        for (CALayer *obj in layers) {
            if ([obj isKindOfClass:[CAGradientLayer class]]) {
                [obj removeFromSuperlayer];
            }
        }
       
    }
    
    if (startColor == nil || endColor == nil) {
        return;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.0),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, self.jk_width, self.jk_height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}


///横向渐变
- (void)crosswiseStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    if (self.layer.sublayers.count > 0) {
        NSMutableArray *layers = [NSMutableArray arrayWithArray:self.layer.sublayers];
        for (CALayer *obj in layers) {
            if ([obj isKindOfClass:[CAGradientLayer class]]) {
                [obj removeFromSuperlayer];
            }
        }
       
    }
    
    if (startColor == nil || endColor == nil) {
        return;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.2),@(1.0)];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = CGRectMake(0, 0, self.jk_width, self.jk_height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}



///横向渐变自定义宽度
- (void)crosswiseWidth:(CGFloat)width StartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    if (self.layer.sublayers.count > 0) {
        NSMutableArray *layers = [NSMutableArray arrayWithArray:self.layer.sublayers];
        for (CALayer *obj in layers) {
            if ([obj isKindOfClass:[CAGradientLayer class]]) {
                [obj removeFromSuperlayer];
            }
        }
       
    }
    
    if (startColor == nil || endColor == nil) {
        return;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.2),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, width, self.jk_height);
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

///横向渐变自定义宽度 类型
- (void)crosswiseWidth:(CGFloat)width StartColor:(UIColor *)startColor endColor:(UIColor *)endColor layerType:(CAGradientLayerType)type {
    if (self.layer.sublayers.count > 0) {
        NSMutableArray *layers = [NSMutableArray arrayWithArray:self.layer.sublayers];
        for (CALayer *obj in layers) {
            if ([obj isKindOfClass:[CAGradientLayer class]]) {
                [obj removeFromSuperlayer];
            }
        }
       
    }
    
    if (startColor == nil || endColor == nil) {
        return;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@(0.2),@(1.0)];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, width, self.jk_height);
    gradientLayer.type = type;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}



@end
