//
//  HSTextView.m
//  HSiOS
//
//  Created by wzk on 2021/8/13.
//

#import "HSTextView.h"
#import "HSKeyboardView.h"


@interface HSTextView()

@end
@implementation HSTextView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)dealloc {
    [[HSKeyboardView sharedHSKeyboardView] diss];
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self addSubview:self.textLabel];
    [self addSubview:self.lineView];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_lessThanOrEqualTo(-5);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(0);
        make.top.equalTo(self.textLabel.mas_top).offset(5);
        make.bottom.equalTo(self.textLabel.mas_bottom).offset(-5);
        make.width.mas_equalTo(2);
    }];

    [self.lineView configCornerRadius:1];
    self.textLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTextLabelTap:)];
    [self.textLabel addGestureRecognizer:tap];
    WeakSelf;
    [HSKeyboardView sharedHSKeyboardView].selectItemNumber = ^(NSString * _Nonnull number) {
        
        if ([number isEqualToString:@"·"]) {
            number = @".";
        }
        if (App_IsEmpty(weakSelf.textLabel.text)) {
            weakSelf.textLabel.text = number;
        }
        else {
            weakSelf.textLabel.text = [NSString stringWithFormat:@"%@%@",weakSelf.textLabel.text,number];
        }
        if (weakSelf.selectTextViewChange) {
            weakSelf.selectTextViewChange(weakSelf);
        }
        
    };
    [HSKeyboardView sharedHSKeyboardView].selectItemBack = ^{
        NSString *text = @"";
        if (App_IsEmpty(weakSelf.textLabel.text)) {
            return;
        }
//        else if (weakSelf.textLabel.text.length == 1) {
//
//        }
        else {
            text = [weakSelf.textLabel.text substringToIndex:weakSelf.textLabel.text.length - 1];
        }
        weakSelf.textLabel.text = text;
        if (weakSelf.selectTextViewChange) {
            weakSelf.selectTextViewChange(weakSelf);
        }
    };
    [HSKeyboardView sharedHSKeyboardView].selectItemOK = ^{
//        [[HSKeyboardView sharedHSKeyboardView] diss];
        if (weakSelf.selectKeyboardOKAction) {
            weakSelf.selectKeyboardOKAction(weakSelf);
        }
    };
    [self addScaleAnimationTo:self.lineView];

}

///加入闪烁动画
- (void)addScaleAnimationTo:(UIView*)animationView {
    [animationView.layer removeAnimationForKey:@"opacity"];
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue=@1.f;
    animation.toValue=@0.0f;
    animation.autoreverses=YES;
    animation.repeatCount= FLT_MAX;
    animation.duration=0.5f;
    [animationView.layer addAnimation:animation forKey:@"scale"];
}

- (void)selectTextLabelTap:(UITapGestureRecognizer *)tap {
    
    [[HSKeyboardView sharedHSKeyboardView] show];
}


#pragma  mark -- getting
- (UILabel *)textLabel {
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = App_PFM_FONT(33);
        _textLabel.textColor = App_333333;
    }
    return _textLabel;
}

- (UILabel *)lineView {
    if (_lineView == nil) {
        _lineView = [[UILabel alloc] init];
        _lineView.backgroundColor = App_UICOLOR_HEX(@"#FC3455");
    }
    return _lineView;
}

- (void)setIsFirstResponse:(BOOL)isFirstResponse {
    if (_isFirstResponse != isFirstResponse) {
        _isFirstResponse = isFirstResponse;
    }
    if (_isFirstResponse) {
        [[HSKeyboardView sharedHSKeyboardView] show];
    }
    else {
        [[HSKeyboardView sharedHSKeyboardView] diss];
    }
}
@end
