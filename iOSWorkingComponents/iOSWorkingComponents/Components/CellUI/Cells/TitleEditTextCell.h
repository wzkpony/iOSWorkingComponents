//
//  TitleEditTextCell.h
//  Crmservice
//
//  Created by wzk on 2020/1/15.
//  Copyright © 2020 wzk. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TitleEditTextCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@end

NS_ASSUME_NONNULL_END
