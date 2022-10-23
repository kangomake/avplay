//
//  CRButton.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/8.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRButton.h"


extern CGFloat const imageViewWH;


@implementation CRButton


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.frame.size.width <= 0) return;
    
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    
    self.titleLabel.frame = CGRectMake(_margin, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    CGFloat imageX = btnW - self.imageView.frame.size.width -  _margin;
    self.imageView.frame = CGRectMake(imageX, (btnH - imageViewWH) * 0.5, imageViewWH, imageViewWH);
    
    //    NSLog(@"%@",NSStringFromCGRect(self.frame));
    //    NSLog(@"%@",NSStringFromCGRect(self.imageView.frame));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
