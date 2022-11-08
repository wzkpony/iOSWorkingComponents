//
//  HSKeyboardView.h
//  HSiOS
//
//  Created by wzk on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSKeyboardView : BaseView
SINGLETON_FOR_HEADER(HSKeyboardView);

@property (copy ,nonatomic) void (^selectItemNumber)(NSString *number);
@property (copy ,nonatomic) void (^selectItemBack)(void);
@property (copy ,nonatomic) void (^selectItemOK)(void);

- (void)show;
- (void)diss;
@end

NS_ASSUME_NONNULL_END
