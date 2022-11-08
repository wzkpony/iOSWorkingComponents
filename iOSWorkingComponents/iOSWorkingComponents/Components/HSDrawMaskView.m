//
//  HSDrawMaskView.m
//  HSiOS
//
//  Created by wzk on 2021/10/16.
//

#import "HSDrawMaskView.h"

@interface HSDrawMaskView()
@property (strong ,nonatomic) CAShapeLayer *fillLayer;

@property (strong ,nonatomic) CAShapeLayer *fillLineLayer;
@end

@implementation HSDrawMaskView

- (void)drawRect:(CGRect)rect {
    self.userInteractionEnabled = NO;
//    self.backgroundColor = App_RGBA(0, 0, 0, 0.8);
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    
    //中间镂空的矩形框
    
    CGRect myRect = self.fillLayerFrame;
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    self.fillLayer.path = path.CGPath;
    [self.layer addSublayer:self.fillLayer];
    
    
    
    UIBezierPath *circleLinePath = [UIBezierPath bezierPathWithRect:myRect];
    self.fillLineLayer.path = circleLinePath.CGPath;
    [self.fillLayer addSublayer:self.fillLineLayer];
    
}

- (CAShapeLayer *)fillLayer {
    if (_fillLayer == nil) {
        _fillLayer = [CAShapeLayer layer];
        _fillLayer.fillRule = kCAFillRuleEvenOdd;
        _fillLayer.fillColor = [UIColor clearColor].CGColor;
        _fillLayer.fillColor = App_RGBA(0, 0, 0, 0.8).CGColor;

        _fillLayer.opacity = 0.5;
    }
    return _fillLayer;
}


- (CAShapeLayer *)fillLineLayer {
    if (_fillLineLayer == nil) {
        _fillLineLayer = [CAShapeLayer layer];
        _fillLineLayer.fillColor = [UIColor clearColor].CGColor;
        //虚线的颜色
        _fillLineLayer.strokeColor = [UIColor whiteColor].CGColor;
        //虚线的宽度
        _fillLineLayer.lineWidth = 2.f;
        //虚线的间隔
        _fillLineLayer.lineDashPattern = @[@10, @5];
        
        //设置线条的样式
    //    fillLineLayer.lineCap = @"square";
       
    }
    return _fillLineLayer;
}

@end
