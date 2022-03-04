//
//  CRMenuButton.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/3.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRMenuButton.h"
#import "UIView+NTES.h"

@implementation CRMenuButton


- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.left < self.titleLabel.left) {
        self.titleLabel.left = self.imageView.left;
        self.imageView.left = self.titleLabel.maxX + 5;
        
    }
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
