//
//  HSImgConfigVC.h
//  HSiOS
//
//  Created by wzk on 2021/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSImgConfigVC : UIViewController
/**
 单张图
 */
@property (strong ,nonatomic) UIImage *image;
@property (nonatomic) CGRect drowFrame;

/**
 多张图
 */
@property (strong ,nonatomic) NSArray<NSDictionary *> *dataSource;

@property (copy ,nonatomic) void(^selectOKButtonBlock)(UIViewController *imgConfigVC,UIImage *image);

@property (strong ,nonatomic) NSArray *templateArrData;

@property (copy ,nonatomic) void(^selectDataSourceOKButtonBlock)(UIViewController *imgConfigVC,NSMutableArray<NSMutableDictionary *> *resultArray);




@end

NS_ASSUME_NONNULL_END
