//
//  myXibCell.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/6/22.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "myXibCell.h"

@interface myXibCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *zanBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;

@end


@implementation myXibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.image = [UIImage imageNamed:@"icon"];
    self.nameLabel.text = @"name测试测试测试测试测试测试";
    self.timeLabel.text = @"2020.6.22";
    [self.zanBtn setTitle:@"up" forState:UIControlStateNormal];
    [self.caiBtn setTitle:@"down" forState:UIControlStateNormal];
    
    // Initialization code
}
- (IBAction)upClick:(id)sender {
}
- (IBAction)downClick:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
