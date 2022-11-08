//
//  EWWaterFallLayout.h
//  HSiOS
//
//  Created by wzk on 2021/1/8.
//瀑布流的Layout

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class EWWaterFallLayout;

@protocol EWWaterFallLayoutDataSource<NSObject>

@required
/**
  * 每个item的高度
  */
- (CGFloat)waterFallLayout:(EWWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterFallLayout:(EWWaterFallLayout *)waterFallLayout;

@end

@interface EWWaterFallLayout : UICollectionViewFlowLayout

/**
 * 代理
 */
@property (nonatomic, weak) id<EWWaterFallLayoutDataSource> delegate;


@end

NS_ASSUME_NONNULL_END
