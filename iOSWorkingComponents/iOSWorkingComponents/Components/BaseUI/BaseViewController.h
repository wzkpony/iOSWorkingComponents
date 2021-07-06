//
//  BaseViewController.h
//  TodayGo
//
//  Created by Felix on 2017/7/16.
//
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/**多返回的页面深度*/
@property(assign,nonatomic)NSInteger backMorePage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navH;
/**聊天发送商品详情*/
@property(nonatomic, assign) BOOL statusBarHidden;/**<default NO。是否显示状态栏>*/
@property(nonatomic, assign) UIStatusBarStyle statusStyle;/**<default UIStatusBarStyleLightContent ,更改状态来样式>*/

- (void)configLeftBarButtonItem:(UIView *)view;
- (void)configRithtBarButtonItem:(UIView *)view;
- (void)configNavBarBackgroundImage:(UIImage *)image;//设置背景图片
- (IBAction)backBtnSelect;

NSString *decimalNumberWithDouble(double conversionValue);
int decimalFloatWithInteger(NSString * conversionValue);
@end
