//
//  UICollectionView+RRSwipeCell.h
//  RRSwipeCell
//
//  Created by Shaw on 7/23/17.
//  Copyright © 2017 Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RRSwipeActionDelegate;
@interface UICollectionView (RRSwipeCell)

@property (nonatomic, weak, nullable) id<RRSwipeActionDelegate> rr_swipeActionDelegate;
@property (nonatomic, assign, readonly) BOOL rr_isActive;
- (void)rr_hideSwipeActions;

@end
