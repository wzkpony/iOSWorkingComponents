//
//  BaseNavBarViewController.m
//  HSiOS
//
//  Created by wzk on 2021/11/25.
//

#import "BaseNavBarViewController.h"

@interface BaseNavBarViewController () {
@private NSString *_title;
}

@property (strong ,nonatomic) UIScrollView *scrollView;
@end

@implementation BaseNavBarViewController
@dynamic title;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.navigationController setNavigationBarHidden:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden  = YES;
    self.tabBarController.fd_prefersNavigationBarHidden  = YES;
    [self.view addSubview:self.nav_View];
    [self.nav_View  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(App_NavHeight);
    }];
    
    [self.nav_View addSubview:self.back_Button];
    [self.back_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
    }];
    
    [self.nav_View addSubview:self.title_Label];
    [self.title_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.right.mas_equalTo(0);
    }];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.back_Button.tintColor = self.back_Button_tintColor?self.back_Button_tintColor:App_333333;

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    for (UIView *view in self.view.subviews) {
        if ([view  isKindOfClass:[UITableView class]]||
            [view  isKindOfClass:[UICollectionView class]]||
            [view  isKindOfClass:[UIScrollView class]]) {
            self.scrollView = view;
            break;
        }
    }
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self.view bringSubviewToFront:self.nav_View];
}

- (void)setHiddenNavView:(BOOL)hiddenNavView  {
    self.nav_View.hidden  = hiddenNavView;
}

- (void)setAlpha:(CGFloat)alpha {
    self.nav_View.backgroundColor = App_RGBA(255, 255, 255, alpha);
}


- (UIView *)nav_View {
    if (_nav_View == nil) {
        _nav_View = [[UIView alloc] init];
        _nav_View.backgroundColor = [UIColor whiteColor];
        
    }
    return _nav_View;
}

- (UIButton *)back_Button {
    if (_back_Button == nil) {
        _back_Button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_back_Button setImage:App_IMAGE(@"goBackIcon") forState:UIControlStateNormal];
        _back_Button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_back_Button addTarget:self action:@selector(backBtnSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _back_Button;
}

- (void)backBtnSelect {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UILabel *)title_Label {
    if (_title_Label == nil) {
        _title_Label = [[UILabel alloc] init];
        _title_Label.font = App_PFM_FONT(17);
        _title_Label.textColor = App_333333;
        _title_Label.textAlignment = NSTextAlignmentCenter;
    }
    return _title_Label;
}

- (void)setBack_Button_tintColor:(UIColor *)back_Button_tintColor {
    _back_Button_tintColor = back_Button_tintColor?back_Button_tintColor:App_333333;
    _back_Button.tintColor =  _back_Button_tintColor;

}


- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.title_Label.text = title;
}

- (NSString *)title {
    return self.title_Label.text;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
