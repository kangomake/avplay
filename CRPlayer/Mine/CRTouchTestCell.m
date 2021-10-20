//
//  CRTouchTestCell.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/20.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "CRTouchTestCell.h"

@implementation CRTouchTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
//        [self addGestureRecognizer:({
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//            tap;
//
//        })];
        
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
