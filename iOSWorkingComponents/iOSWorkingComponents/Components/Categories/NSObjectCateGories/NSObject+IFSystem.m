//
//  NSObject+IFSystem.m
//  IronFish
//
//  Created by wzk on 2018/12/25.
//  Copyright © 2018 wzk. All rights reserved.
//

#import "NSObject+IFSystem.h"
#import "MBProgressHUD+LL.h"

@implementation NSObject (IFSystem)
#pragma mark - 使用系统邮件客户端发送邮件
/**
 recipients:收件人
 subject :主题
 messageBody :内容
 */
+ (MFMailComposeViewController *)launchMailAppDelegateRecipients:(NSArray<NSString *> *)recipients subject:(NSString *)subject messageBody:(NSString *)messageBody delegate:(id<MFMailComposeViewControllerDelegate>)obj
{
    MFMailComposeViewController *picker = nil;
    if([MFMailComposeViewController canSendMail]) {// 判断设备是否支持发送邮件
        // 创建对象
        picker = [[MFMailComposeViewController alloc]init];
        // 设置代理
        picker.mailComposeDelegate = obj;
        picker.navigationBar.tintColor= [UIColor blackColor];
        // 设置收件人
        [picker setToRecipients:recipients];
        // 设置主题
        [picker setSubject:subject];
        // 设置邮件内容
        [picker setMessageBody:messageBody isHTML:NO];
       
    }
    else{
        [MBProgressHUD ll_showErrorMessage:@"请先设置登录邮箱号"];
    }
  
    return picker;
}

- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *temp in windows) {
            if (temp.windowLevel == UIWindowLevelNormal) {
                window = temp;
                break;
            }
        }
    }
    
    result = window.rootViewController;
    
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result visibleViewController];
    }
    return result;
}

@end
