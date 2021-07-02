//
//  ZJYStarRateView.h
//  XHStarRateView
//
//  Created by 王学文 on 2017/9/6.
//  Copyright © 2017年 jxh. All rights reserved.
//
/**
 星星评价级别。
 🌟🌟🌟🌟🌟
 五星好评，一星差评
 
 */

#import <UIKit/UIKit.h>
@class ZJYStarRateView;

typedef void(^finishBlock)(CGFloat currentScore);

typedef NS_ENUM(NSInteger, ZJYRateStyle)
{
    ZJYWholeStar = 0, //只能整星评论
    ZJYHalfStar = 1,  //允许半星评论
    ZJYIncompleteStar = 2  //允许不完整星评论
};

@protocol ZJYStarRateViewDelegate <NSObject>

-(void)starRateView:(ZJYStarRateView *)starRateView currentScore:(CGFloat)currentScore;

@end

@interface ZJYStarRateView : UIView

@property (nonatomic,assign)BOOL isAnimation;       //是否动画显示，默认NO
@property (nonatomic,assign)ZJYRateStyle rateStyle;    //评分样式    默认是WholeStar
@property (nonatomic, weak) id<ZJYStarRateViewDelegate>delegate;
@property (nonatomic,assign)CGFloat currentScore;   // 当前评分：0-5  默认0
@property (nonatomic,assign)CGFloat starSpaceing; //星间距 默认 10

-(instancetype)initWithFrame:(CGRect)frame withWidth:(CGFloat)width;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(ZJYRateStyle)rateStyle isAnination:(BOOL)isAnimation delegate:(id)delegate withWidth:(CGFloat)width;


-(instancetype)initWithFrame:(CGRect)frame withWidth:(CGFloat)width finish:(finishBlock)finish ;
-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars rateStyle:(ZJYRateStyle)rateStyle withWidth:(CGFloat)width isAnination:(BOOL)isAnimation finish:(finishBlock)finish;


/// test
@property (strong, nonatomic) UIViewController *testVC;

@end
