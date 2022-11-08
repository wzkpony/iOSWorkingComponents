//
//  AnimationForMe.h
//  WZKPonyCount
//
//  Created by 王正魁 on 14-9-16.
//  Copyright (c) 2014年 Psylife_iMac02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface WZKAnimation : NSObject


/** type
 *
 *  各种动画效果  其中除了'fade', `moveIn', `push' , `reveal' ,其他属于似有的API(我是这么认为的,可以点进去看下注释).
 *  ↑↑↑上面四个可以分别使用'kCATransitionFade', 'kCATransitionMoveIn', 'kCATransitionPush', 'kCATransitionReveal'来调用.
 *  @"cube"                     立方体翻滚效果
 *  @"moveIn"                   新视图移到旧视图上面
 *  @"reveal"                   显露效果(将旧视图移开,显示下面的新视图)
 *  @"fade"                     交叉淡化过渡(不支持过渡方向)             (默认为此效果)
 *  @"pageCurl"                 向上翻一页
 *  @"pageUnCurl"               向下翻一页
 *  @"suckEffect"               收缩效果，类似系统最小化窗口时的神奇效果(不支持过渡方向)
 *  @"rippleEffect"             滴水效果,(不支持过渡方向)
 *  @"oglFlip"                  上下左右翻转效果
 *  @"rotate"                   旋转效果
 *  @"push"
 *  @"cameraIrisHollowOpen"     相机镜头打开效果(不支持过渡方向)
 *  @"cameraIrisHollowClose"    相机镜头关上效果(不支持过渡方向)
 *
 *
 *  kCATransitionFade            交叉淡化过渡
 *  kCATransitionMoveIn          新视图移到旧视图上面
 *  kCATransitionPush            新视图把旧视图推出去
 *  kCATransitionReveal          将旧视图移开,显示下面的新视图
 * subtype
 *
 *  各种动画方向
 *
 *  kCATransitionFromRight;      同字面意思(下同)
 *  kCATransitionFromLeft;
 *  kCATransitionFromTop;
 *  kCATransitionFromBottom;
 *
 *
 *  当type为@"rotate"(旋转)的时候,它也有几个对应的subtype,分别为:
 *  90cw    逆时针旋转90°
 *  90ccw   顺时针旋转90°
 *  180cw   逆时针旋转180°
 *  180ccw  顺时针旋转180°
 * fillMode
 *
 *  决定当前对象过了非active时间段的行为,比如动画开始之前,动画结束之后.
 *  预置为:
 *  kCAFillModeRemoved   默认,当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
 *  kCAFillModeForwards  当动画结束后,layer会一直保持着动画最后的状态
 *  kCAFillModeBackwards 和kCAFillModeForwards相对,具体参考上面的URL
 *  kCAFillModeBoth      kCAFillModeForwards和kCAFillModeBackwards在一起的效果
 *
 *
 * timingFunction
 *
 *  用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是均匀变化(相同时间变化量相同)还是
 *  先快后慢,先慢后快还是先慢再快再慢.
 *
 *  动画的开始与结束的快慢,有五个预置分别为(下同):
 *  kCAMediaTimingFunctionLinear            线性,即匀速
 *  kCAMediaTimingFunctionEaseIn            先慢后快
 *  kCAMediaTimingFunctionEaseOut           先快后慢
 *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
 *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
 *
 * delegate
 *
 *  动画的代理,如果你想在动画开始和结束的时候做一些事,可以设置此属性,它会自动回调两个代理方法.
 *  这里就是 theView
 *  @see CAAnimationDelegate
 */

+ (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction
                     view:(UIView *)theView;

#pragma mark - Preset Animation

/**
 *  下面是一些常用的动画效果
 */

// reveal
+ (void)animationReveal:(UIView *)view durationd:(float)durationd type:(NSString *)type subtype:(NSString *)Subtype fillMode:(NSString *)FillMode timing:(NSString *)timing;


// 渐隐渐消 翻转 翻页

+ (void)animationFlipFromLeft:(UIView *)view animationCurve:(UIViewAnimationCurve)curve duration:(float)duration transtion:(UIViewAnimationTransition)transtion;

// push
+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;

// move
+ (void)animationMoveUp:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveDown:(UIView *)view duration:(CFTimeInterval)duration;
+ (void)animationMoveLeft:(UIView *)view;
+ (void)animationMoveRight:(UIView *)view;

// 旋转缩放

// 各种旋转缩放效果
+ (void)animationRotateAndScaleEffects:(UIView *)view;

// 旋转同时缩小放大效果
+ (void)animationRotateAndScaleDownUp:(UIView *)view;



#pragma mark - Private API

/**
 *  下面动画里用到的某些属性在当前API里是不合法的,但是也可以用.
 */

+ (void)animationFlipFromTop:(UIView *)view;
+ (void)animationFlipFromBottom:(UIView *)view;

+ (void)animationCubeFromLeft:(UIView *)view;
+ (void)animationCubeFromRight:(UIView *)view;
+ (void)animationCubeFromTop:(UIView *)view;
+ (void)animationCubeFromBottom:(UIView *)view;

+ (void)animationSuckEffect:(UIView *)view;

+ (void)animationRippleEffect:(UIView *)view;

+ (void)animationCameraOpen:(UIView *)view;
+ (void)animationCameraClose:(UIView *)view;
@end
