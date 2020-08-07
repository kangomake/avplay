//
//  CRFPSLabel.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/4.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRFPSLabel.h"


@implementation CRFPSLabel{
    
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
    
    NSTimeInterval _llll;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(click:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return self;
}


- (void)click:(CADisplayLink *)link{
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
