//
//  ProgressView.m
//  HSiOS
//
//  Created by wzk on 2021/12/8.
//

#import "ProgressView.h"
@interface ProgressView()
@property (strong, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UIView *progressContentsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressContentsViewW;

@end

@implementation ProgressView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.contentsView == nil) {
        self.contentsView = [[UINib nibWithNibName:@"ProgressView" bundle:nil] instantiateWithOwner:self options:nil].lastObject;
    }
    
    [self addSubview:self.contentsView];
    
    [self.contentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    self.contentsView.backgroundColor = self.backViewColor?self.backViewColor:App_UICOLOR_HEX(@"#FFF5F8");;
    self.progressContentsView.backgroundColor = self.progressColor?self.progressColor:App_UICOLOR_HEX(@"#FF8DA0");
    
    [self.contentsView configCornerRadius:self.jk_height/2.0];
    [self.progressContentsView configCornerRadius:self.jk_height/2.0];
    
    self.progressContentsViewW.constant = self.jk_width*_progress;
}




- (void)setBackViewColor:(UIColor *)backViewColor {
    _backViewColor = backViewColor;
    _contentsView.backgroundColor = backViewColor?backViewColor:App_UICOLOR_HEX(@"#FFF5F8");
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    _progressContentsView.backgroundColor = progressColor?progressColor:App_UICOLOR_HEX(@"#FF8DA0");
}

- (void)setProgress:(CGFloat)progress {
    if (progress > 1) {
        progress = 1;
    }
    _progress = progress;
    self.progressContentsViewW.constant = self.jk_width*_progress;
}

@end
