//
//  HudTool.h
//  GeneEggBiota
//
//  Created by 丁冬冬 on 2019/7/25.
//  Copyright © 2019 丁冬冬. All rights reserved.
//  可变层级吐司HUD

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HudTool : NSObject

- (id)initWithView:(UIView *)view;
- (id)initWithWindow;
- (void)hideLoadWithAnimated:(BOOL)animated;
- (void)showLoadWithAnimated:(BOOL)animated;
- (void)showLoadWithAnimated:(BOOL)animated title:(NSString *)title;
- (void)showDIYLoadingWithAnimated:(BOOL)animated title:(NSString *)title;
- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide;
- (void)showInfo:(NSString *)info autoHidden:(BOOL)autoHide animated:(BOOL)animated;
- (void)showInfo:(NSString *)info image:(UIImage *)image hiddenDelay:(NSTimeInterval)delay animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
