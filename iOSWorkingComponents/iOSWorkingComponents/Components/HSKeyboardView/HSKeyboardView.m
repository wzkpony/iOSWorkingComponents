//
//  HSKeyboardView.m
//  HSiOS
//
//  Created by wzk on 2021/8/13.
//

#import "HSKeyboardView.h"

@interface HSKeyboardView()

@end

@implementation HSKeyboardView
SINGLETON_FOR_CLASS(HSKeyboardView);


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}



/**将View加到keyWindow 上*/
- (void)show {
    if (self.frame.origin.y < App_HEIGHT && self.frame.origin.y != 0) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    UIView *viewBg = [[UIView alloc] init];
//    viewBg.frame = window.bounds;
//    viewBg.tag = 987771;
//    viewBg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
//
//    viewBg.userInteractionEnabled = YES;
//    if (self.notTap == NO) {
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePOP)];
//        [viewBg addGestureRecognizer:tap];
//    }
//    [window addSubview:viewBg];
    CGFloat H = IS_PAD?270:240*App_SCREEN_RATIO6;
    self.frame = CGRectMake(0, App_HEIGHT, App_WIDTH, H);
    [window addSubview:self];
    [UIView animateWithDuration:0.33 animations:^{
        self.frame = CGRectMake(0, App_HEIGHT - H, App_WIDTH, H);
    }];
}

- (void)diss {
    CGFloat H = IS_PAD?270:240*App_SCREEN_RATIO6;

    [UIView animateWithDuration:0.33 animations:^{
        self.frame = CGRectMake(0, App_HEIGHT, App_WIDTH, H);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        UIView *viewBg = [window viewWithTag:100099];
//        [viewBg removeFromSuperview];
        
    }];
  
}

- (IBAction)selectItemNumberButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.selectItemNumber) {
        self.selectItemNumber(button.currentTitle);
    }
}

- (IBAction)selectBackButton:(id)sender {
    if (self.selectItemBack) {
        self.selectItemBack();
    }
}

- (IBAction)selectOKButton:(id)sender {
    if (self.selectItemOK) {
        self.selectItemOK();
    }
}


@end
