//
//  HSTextView.h
//  HSiOS
//
//  Created by wzk on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSTextView : UIView
@property (strong ,nonatomic) UILabel *textLabel;

@property (strong ,nonatomic) UILabel *lineView;

@property (assign ,nonatomic) BOOL isFirstResponse;

@property (copy ,nonatomic) void (^selectKeyboardOKAction)(HSTextView *textView);

@property (copy ,nonatomic) void (^selectTextViewChange)(HSTextView *textView);


@end

NS_ASSUME_NONNULL_END
