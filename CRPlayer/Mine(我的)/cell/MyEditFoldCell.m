//
//  MyEditFoldCell.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/10/28.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "MyEditFoldCell.h"
#import <Masonry/Masonry.h>


#import "CRScreen.h"

@implementation MyEditFoldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.text = @"描述描述";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.titleLabel sizeToFit];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.returnKeyType = UIReturnKeyDone;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.font = [UIFont systemFontOfSize:14];
        textField.placeholder = @"请填写";
//        [self.contentView addSubview:textField];
        self.textField = textField;
  

        
        

        CGFloat offset = 15;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.contentView).offset(offset);
            make.top.equalTo(self.contentView).offset(offset);
//            make.centerY.equalTo(self.contentView);
        }];
        
//        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@30);
//            make.left.equalTo(self.contentView).offset(offset);
//            make.top.equalTo(self.titleLabel).offset(offset);
//            make.right.equalTo(self.contentView).offset(-offset);
//
//        }];
        
        
    }
    return self;
}


- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:12];
        _textView.textColor = RGB(102, 102, 102);
        _textView.textAlignment = NSTextAlignmentLeft;
//        _textView.delegate = self;
    }
    return _textView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
