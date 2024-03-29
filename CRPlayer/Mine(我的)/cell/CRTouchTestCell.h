//
//  CRTouchTestCell.h
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/20.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cellFoldModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRTouchTestCell : UITableViewCell

@property (nonatomic, strong) cellFoldModel *foldModel;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
