#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspensionButton : UIButton

@property(nonatomic, assign)BOOL MoveEnable;
@property(nonatomic, assign)BOOL MoveEnabled;
@property(nonatomic, assign)CGPoint beginpoint;

@property (strong ,nonatomic) UILabel *numberLabel;
@end

NS_ASSUME_NONNULL_END
