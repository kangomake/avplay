//
//  CRCover.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/3/3.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRCover.h"

@implementation CRCover


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_clickCover) {
        _clickCover();
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
