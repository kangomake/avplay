//
//  MyEditFoldCell.h
//  CRPlayer
//
//  Created by appleDeveloper on 2021/10/28.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyEditFoldCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong)UITextView *textView;

@property (nonatomic, copy) void (^cellClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
