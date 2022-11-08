//
//  NSObject+IFSystem.h
//  IronFish
//
//  Created by wzk on 2018/12/25.
//  Copyright © 2018 wzk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (IFSystem)

/**
 recipients:收件人
 subject :主题
 messageBody :内容
 return MFMailComposeViewController //邮箱的VC
 */
+ (MFMailComposeViewController *)launchMailAppDelegateRecipients:(NSArray<NSString *> *)recipients subject:(NSString *)subject messageBody:(NSString *)messageBody delegate:(id<MFMailComposeViewControllerDelegate>)obj;

///获取当前的VC
- (UIViewController *)getCurrentVC;

///限制字符长度
- (void)textFieldDidChange:(UITextField *)textField interger:(NSUInteger)integer;

#pragma  mark -- 选择照片 照片的逻辑开始 --
//- (void)showAlertViewForPic;
@end

NS_ASSUME_NONNULL_END
