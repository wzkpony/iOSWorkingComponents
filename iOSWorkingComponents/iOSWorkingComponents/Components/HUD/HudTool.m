//
//  HudTool.m
//  GeneEggBiota
//
//  Created by 丁冬冬 on 2019/7/25.
//  Copyright © 2019 丁冬冬. All rights reserved.
//

#import "HudTool.h"
#import <MBProgressHUD.h>
#import "ColorConfig.h"

@interface HudTool ()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, weak) UIView *view;

@end

@implementation HudTool

- (id)init
{
    NSAssert(NO, @"使用initWithView:或者initWithWindow");
    return nil;
}

- (id)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.view = view;
        self.hud = [[MBProgressHUD alloc] initWithView:view];
        self.hud.removeFromSuperViewOnHide = NO;
        [self.view addSubview:self.hud];
    }
    return self;
}

- (id)initWithWindow
{
    self = [super init];
    if (self) {
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        UIWindow *lastWindow = (UIWindow *)[windows lastObject];
//        lastWindow.windowLevel = lastWindow.windowLevel + 1;
        
        self.view = lastWindow;
        
        self.hud = [[MBProgressHUD alloc]initWithView:self.view];
        self.hud.removeFromSuperViewOnHide = NO;
        [self.view addSubview:self.hud];
        
    }
    return self;
}



- (void)hideLoadWithAnimated:(BOOL)animated
{
    [self.hud hideAnimated:NO];
}

- (void)showLoadWithAnimated:(BOOL)animated
{
    [self showLoadWithAnimated:animated title:@""];
}

- (void)showDIYLoadingWithAnimated:(BOOL)animated title:(NSString *)title
{
    MBProgressHUD *hud = self.hud;
    hud.label.text = @"";
    hud.bezelView.alpha = 0.8f;
    hud.bezelView.color = App_UIColorFromRGBAlpha(0x6e6e6e, 0.74);
    hud.bezelView.layer.cornerRadius = 5;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = title;
    [self.view bringSubviewToFront:hud];
    hud.hidden = NO;
    [hud showAnimated:YES];
}

- (void)showLoadWithAnimated:(BOOL)animated title:(NSString *)title
{
    MBProgressHUD *hud = self.hud;
    if (![title isEqualToString:@""]) {
        hud.label.text = @"";
        hud.bezelView.alpha = 0.8f;
        hud.bezelView.color = App_UIColorFromRGBAlpha(0x6e6e6e, 0.74);
        hud.bezelView.layer.cornerRadius = 31.5;
        hud.mode = MBProgressHUDModeCustomView;
        hud.detailsLabel.font = hud.label.font;
        hud.detailsLabel.text = title;
    }
    [self.view bringSubviewToFront:hud];
    hud.hidden = NO;
    [hud showAnimated:YES];
}

- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide
{
    [self showInfo:info autoHidden:autoHide animated:YES];
}

- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide animated:(BOOL)animated
{
    [self showInfo:info image:nil hiddenDelay:1.5 animated:animated];
}

- (void)showInfo:(NSString *)info image:(UIImage *)image hiddenDelay:(NSTimeInterval)delay animated:(BOOL)animated
{
    MBProgressHUD *hud = self.hud;
    hud.label.text = @"";
    hud.bezelView.alpha = 0.8f;
    if (image) {
        hud.customView = [[UIImageView alloc] initWithImage:image];
    } else{
        hud.customView = nil;
    }
    hud.bezelView.color = App_UIColorFromRGBAlpha(0x6e6e6e, 0.74);
    hud.bezelView.layer.cornerRadius = 31.5;
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabel.font = hud.label.font;
    hud.detailsLabel.text = info;
    
    [self.view bringSubviewToFront:hud];
    hud.hidden = NO;
    [hud showAnimated:YES];
    if (delay > 0) {
        [hud hideAnimated:YES afterDelay:delay];
    }
}

@end
