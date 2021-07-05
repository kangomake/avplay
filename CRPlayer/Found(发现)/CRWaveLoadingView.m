//
//  CRWaveLoadingView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/27.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRWaveLoadingView.h"

@interface CRWaveLoadingView ()

@property (nonatomic, strong) UIImageView *sineImage;
@property (nonatomic, strong) UIImageView *coseImage;
@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) CAShapeLayer *sineLayer;
@property (nonatomic, strong) CAShapeLayer *coseLayer;
@property (nonatomic, strong) CADisplayLink *displayLink;


@property (nonatomic, assign) CGFloat frequency;

@property (nonatomic, assign) CGFloat waveWidth;
@property (nonatomic, assign) CGFloat waveHeight;
@property (nonatomic, assign) CGFloat waveMid;
@property (nonatomic, assign) CGFloat maxAmplitude;

@property (nonatomic, assign) CGFloat phaseShift;
@property (nonatomic, assign) CGFloat phase;


@end

@implementation CRWaveLoadingView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        self.sineLayer = [CAShapeLayer layer];
        self.sineLayer.fillColor = [UIColor greenColor].CGColor;
        self.sineLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.sineLayer.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
            
        
        self.coseLayer = [CAShapeLayer layer];
        self.coseLayer.fillColor = [UIColor greenColor].CGColor;
        self.coseLayer.backgroundColor = [UIColor clearColor].CGColor;
        self.coseLayer.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        
        self.sineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.sineImage.image = [UIImage imageNamed:@"du_blue"];
        
        self.coseImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.coseImage.image = [UIImage imageNamed:@"du_lightblue"];
        
        self.backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.backImage.image = [UIImage imageNamed:@"du_gray"];
        
        self.sineImage.layer.mask = self.sineLayer;
        self.coseImage.layer.mask = self.coseLayer;
        
        [self addSubview:self.backImage];
        [self addSubview:self.sineImage];
        [self addSubview:self.coseImage];
        
        self.waveHeight = CGRectGetHeight(self.bounds) *0.5;
        self.waveWidth = CGRectGetWidth(self.bounds);
        self.frequency = 0.3;
        self.phaseShift = 5;
        self.waveMid = self.waveWidth/2.0f;
        self.maxAmplitude = self.waveHeight *0.3;
        
    }
    return self;
    
}


#pragma mark -- Public Methods
- (void)startLoading{
    
    [self.displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    CGPoint position = self.sineLayer.position;
    position.y = position.y - self.bounds.size.height - 10;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.sineLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:position];
    animation.duration= 5.0;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    
    [self.sineLayer addAnimation:animation forKey:@"positionWave"];
    [self.coseLayer addAnimation:animation forKey:@"positionWave"];
    
}

- (void)stopLoading{
    
    [self.displayLink invalidate];
    [self.sineLayer removeAllAnimations];
    [self.coseLayer removeAllAnimations];
    self.sineLayer.path = nil;
    self.coseLayer.path = nil;
    
}


- (void)updateWave:(CADisplayLink *)displayLink{
    
    self.phase += self.phaseShift;
    self.sineLayer.path = [self createWavePathWithType:1].CGPath;
    self.coseLayer.path = [self createWavePathWithType:0].CGPath;
    
}

- (UIBezierPath *)createWavePathWithType:(NSInteger)type{
    
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for(CGFloat x = 0; x<self.waveWidth +1; x +=1){
        
        endX = x;
        CGFloat y = 0;
        if(type ==1){
            y = self.maxAmplitude * sinf(360.0 /self.waveWidth *(x *M_PI /180) *self.frequency + self.phase * M_PI /180) + self.maxAmplitude;
        }else{
            y = self.maxAmplitude * cosf(360.0 /self.waveWidth *(x *M_PI /180) *self.frequency + self.phase * M_PI /180) + self.maxAmplitude;
        }
    
        if(x == 0){
            [wavePath moveToPoint:CGPointMake(x, y)];
        }else{
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
        
    }
    
    CGFloat endY = CGRectGetHeight(self.bounds) +10;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    
    return wavePath;
      
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
