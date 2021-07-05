//
//  CRNotifier.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/16.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRNotifier.h"
#import "AppDelegate.h"


@import AudioToolbox;

static void VibrateCompletion(SystemSoundID soundID,void *data){
    
    id notifier = (__bridge id)data;
    if([notifier isKindOfClass:[CRNotifier class]]){
        
        SEL selector = NSSelectorFromString(@"vibrate");
        [(CRNotifier *)notifier performSelector:selector withObject:nil afterDelay:1.0];
        
        
    }
    
}



@interface CRNotifier ()

@property (nonatomic, strong) UILocalNotification *currentNotification;
@property (nonatomic, assign) BOOL shouldStopVibrate;
@property (nonatomic, assign) NSInteger vibrateCount;


@end


@implementation CRNotifier

- (instancetype)init{
    
    if(self = [super init]){
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
    }
    return self;
}

- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)start:(NSString *)text{
    
//    [self stop];
    _vibrateCount = 0;
    _shouldStopVibrate = NO;
    
    [self raiseNotification:text];
//    [self vibrate];
    
}

- (void)stop{
    
    if(_currentNotification){
        [[UIApplication sharedApplication] cancelLocalNotification:_currentNotification];
        _currentNotification = nil;
    }
    _shouldStopVibrate = YES;
    
}

- (void)WillEnterForeground:(NSNotification *)notification{
    
//    [self stop];
}

- (void)vibrate{
    
    if(!_shouldStopVibrate){
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, VibrateCompletion, (__bridge  void *)self);
        _vibrateCount ++;
        if(_vibrateCount >= 15){
            _shouldStopVibrate = YES;
        }
        
    }
    
}


- (void)raiseNotification:(NSString *)text{
    
    _currentNotification = [[UILocalNotification alloc] init];
    _currentNotification.soundName = @"";
    _currentNotification.alertBody = text;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:_currentNotification];
}

@end
