//
//  Tool_Audio.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/13.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^AudioRecorderFinishedCompletionBlock)(BOOL isSuccess);
typedef void(^PlaybackFinishedCompletionBlock) (void);
typedef void(^VoiceAnnouncementsFinishedCompletionBlock) (void);

@interface Tool_Audio : NSObject
//单例初始化
+ (instancetype)shareTool;

//开始播放音频和地址
- (void)audioPlayerPlayWithUrl:(NSURL *)url finishedCompletion:(PlaybackFinishedCompletionBlock)block;

//暂停播放音频
-(void)audioPlayerPause;


//开始录音,返回是否成功
-(BOOL)audioRecorderRecordWithPath:(NSString *)path;

//结束录音
-(void)audioRecorderStopWitnCompletion:(AudioRecorderFinishedCompletionBlock)block;


//语音播报
-(void)voiceAnnouncementsText:(NSString *)text WitnCompletion:(VoiceAnnouncementsFinishedCompletionBlock)block;
//语音停止播报
-(void)voiceStopBroadcast;

@end

NS_ASSUME_NONNULL_END
