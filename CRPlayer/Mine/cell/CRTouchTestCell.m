//
//  CRTouchTestCell.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/20.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "CRTouchTestCell.h"
#import <Masonry/Masonry.h>

@implementation CRTouchTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *Identifier = @"cellIdentifier";
    CRTouchTestCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        cell = [[CRTouchTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    
    return cell;
}


//iOS自动布局Autolayout 优先级的使用 https://www.cnblogs.com/junhuawang/p/5691302.html
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
//        [self addGestureRecognizer:({
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//            tap;
//
//        })];
        
        
        
        UILabel* leftLabel = [[UILabel alloc] init];
//            leftLabel.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:leftLabel];
            leftLabel.text = @"";
            [leftLabel sizeToFit];
        self.leftLabel = leftLabel;
        
        
            UILabel* rightLabel = [[UILabel alloc] init];
//            rightLabel.backgroundColor = [UIColor greenColor];
            [self.contentView addSubview:rightLabel];
            rightLabel.text = @"1234567890";
            [rightLabel sizeToFit];
        self.rightLabel = rightLabel;
        
        [leftLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow  forAxis:UILayoutConstraintAxisHorizontal];
        [rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

        CGFloat offset = 15;
        
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.contentView).offset(offset);
            make.centerY.equalTo(self.contentView);
            make.right.mas_lessThanOrEqualTo(rightLabel.mas_left);
        }];
        
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.mas_greaterThanOrEqualTo(leftLabel.mas_right);
            make.right.equalTo(self.contentView).offset(-offset);
            make.width.mas_lessThanOrEqualTo(@200);
            make.centerY.equalTo(leftLabel);
        }];
        
        
        
    }
    return self;
}

- (void)tap{
    
}

- (void)setFoldModel:(cellFoldModel *)foldModel{
    
    _foldModel = foldModel;
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__FUNCTION__);
//    NSLog(@"touches-%@,event-%@",touches,event);
    [super touchesBegan:touches withEvent:event];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
