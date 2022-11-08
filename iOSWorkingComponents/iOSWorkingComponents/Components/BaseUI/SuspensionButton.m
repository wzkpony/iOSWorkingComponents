#import "SuspensionButton.h"
static const CGFloat floatButtonH = 68;

@implementation SuspensionButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - floatButtonH, App_HEIGHT - 50 - floatButtonH - 80 - App_BottomHeight, floatButtonH, floatButtonH);
        [self setBackgroundImage:[UIImage imageNamed:@"float_goodscar_icon"] forState:UIControlStateNormal];
//        [self setTitle:@"" forState:UIControlStateNormal];
//        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _MoveEnable = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(16);
        make.width.mas_greaterThanOrEqualTo(16);
        make.height.mas_greaterThanOrEqualTo(16);
    }];
    [self.numberLabel configCornerRadius:8];
}

//开始触摸的方法
//触摸-清扫
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _MoveEnabled = NO;
    [super touchesBegan:touches withEvent:event];
    if (!_MoveEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    _beginpoint = [touch locationInView:self];
}

//触摸移动的方法
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    _MoveEnabled = YES;//单击事件可用
    if (!_MoveEnable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    //偏移量
    float offsetX = currentPosition.x - _beginpoint.x;
    float offsetY = currentPosition.y - _beginpoint.y;
    //移动后的中心坐标
    self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
    
    //x轴左右极限坐标
    if (self.center.x > (self.superview.frame.size.width - self.frame.size.width / 2)) {
        CGFloat x = self.superview.frame.size.width - self.frame.size.width / 2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    } else if (self.center.x < self.frame.size.width / 2) {
        CGFloat x = self.frame.size.width / 2;
        self.center = CGPointMake(x, self.center.y + offsetY);
    }
    
    //y轴上下极限坐标
    if (self.center.y > (self.superview.frame.size.height - self.frame.size.height)) {
        CGFloat x = self.center.x;
        CGFloat y = self.superview.frame.size.height - self.frame.size.height * 1.5;
        self.center = CGPointMake(x, y);
    } else if (self.center.y <= self.frame.size.height) {
        CGFloat x = self.center.x;
        CGFloat y = self.frame.size.height * 1.2;
        self.center = CGPointMake(x, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_MoveEnable) {
        return;
    }
    
    if (self.center.x >= self.superview.frame.size.width / 2) {//向右侧移动
        //偏移动画
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.33];
        [UIView setAnimationDelegate:self];
        self.frame = CGRectMake(self.superview.frame.size.width - floatButtonH, self.center.y - floatButtonH/2.0, floatButtonH, floatButtonH);
        //提交UIView动画
        [UIView commitAnimations];
    } else {//向左侧移动
        
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.33];
        [UIView setAnimationDelegate:self];
        self.frame=CGRectMake(0.f,self.center.y - floatButtonH/2.0, floatButtonH, floatButtonH);
        //提交UIView动画
        [UIView commitAnimations];
    }
    
    //不加此句话，UIButton将一直处于按下状态
    [super touchesEnded: touches withEvent: event];
    
}

- (UILabel *)numberLabel {
    if (_numberLabel == nil) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = App_SystemFont(10);
        _numberLabel.backgroundColor = App_RGBA(0, 0, 0, 0.65);
        
    }
    return _numberLabel;
}
@end
