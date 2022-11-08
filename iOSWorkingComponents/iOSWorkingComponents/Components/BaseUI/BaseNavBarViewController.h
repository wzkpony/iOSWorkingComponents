//
//  BaseNavBarViewController.h
//  HSiOS
//
//  Created by wzk on 2021/11/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavBarViewController : UIViewController
@property (strong ,nonatomic) UIView *nav_View;
@property (strong ,nonatomic) UIButton *back_Button;
@property (strong ,nonatomic) UILabel *title_Label;
@property (copy ,nonatomic) NSString *title;


@property (assign ,nonatomic) BOOL hiddenNavView;

@property (assign ,nonatomic)  CGFloat alpha;

@property (strong ,nonatomic) UIColor *back_Button_tintColor;

@end

NS_ASSUME_NONNULL_END
