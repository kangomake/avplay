//
//  Tool_Audio.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/13.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "Tool_Audio.h"
#import <AVFoundation/AVFoundation.h>

@interface Tool_Audio ()<AVAudioRecorderDelegate,AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVPlayer *player_;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder_;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;


@property(nonatomic,copy)AudioRecorderFinishedCompletionBlock audioRecorderFinishedBlock;
@property(nonatomic,copy)PlaybackFinishedCompletionBlock playbackFinishedBlock;
@property(nonatomic,copy)VoiceAnnouncementsFinishedCompletionBlock voiceAnnouncementsFinishedBlock;


@end


@implementation Tool_Audio

+ (instancetype)shareTool{
    static Tool_Audio *_shareTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareTool = [[Tool_Audio alloc]init];
    });
    return _shareTool;
}

#pragma mark - 播放音乐

-(void)audioPlayerPlayWithUrl:(NSURL *)url finishedCompletion:(PlaybackFinishedCompletionBlock)block{
    
    /*
     http://www.cnblogs.com/kenshincui/p/4186022.html#music
     从上面可知，播放音乐有的方式
     方式一：AudioToolbox.framework 里的 System Sound Services 音效
     音效播放，时间短，30秒内，本地的
     方式二：AudioToolbox.framework 里的 Audio Queue Services
     在线音乐播放，基于C，（第三方框架：FreeStreamer）
     方式三：AVFoundation 里的 AVAudioPlayer
     本地播放
     方式四：AVFoundation 里的 AVPlayer
     视频播放器，当然也可以用于音乐播放，可在线播放
     方式五：AVFoundation 里的 AVQueuePlayer
     AVPlayer的子类，视频播放器，当然也可以用于音乐播放，可在线播放，可用于多个音乐播放
     https://blog.csdn.net/dolacmeng/article/details/77430108
     AVAudioPlayer、AVPlayer、AVQueuePlayer可以从上面的网址了解
     */
    
    /*
     本地播放要用
     [NSURL fileURLWithPath:@"path"]
     网络播放要用
     [NSURL URLWithString:@"path"]
     */
    
    //设置当前音频为播放状态
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    self.playbackFinishedBlock = block;
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.player_ = [[AVPlayer alloc] initWithPlayerItem:item];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player_.currentItem];
    
    
    [self.player_ play];
    
    
}

- (void)playbackFinished:(NSNotification *)noti{
    if (self.playbackFinishedBlock) {
        self.playbackFinishedBlock();
    }
    
}

#pragma mark - 暂停播放音乐

-(void)audioPlayerPause{
    [self.player_ pause];
}

#pragma mark - 录音

-(BOOL)audioRecorderRecordWithPath:(NSString *)path{
    /*
     录音就只要这一个AVFoundation里的AVAudioRecorder
     但是需要注意的是，使用前要调用[AVAudioSession sharedInstance]，去激活当前的会话然后取录音
     */
    
    //1.设置音频激活为录音状态
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    
    /*
     //因为录音文件比较大，所以我们把它存在Temp文件里，Temp文件里的文件在app重启的时候会自动删除
     _recordFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent: @"record.caf"];
     //创建临时文件来存放录音文件
     _recordUrl = [NSURL fileURLWithPath:self.recordFilePath];
     */
    //设置路径
    //    NSString *pathUrlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    //    pathUrlStr=[pathUrlStr stringByAppendingPathComponent:kRecordAudioFile];
    //    NSLog(@"\n===========\n音频录制文件路径保存:%@\n",pathUrlStr);
    //    NSURL *pathUrl=[NSURL fileURLWithPath:pathUrlStr];
    
    /*
     * settings 参数
     1.AVNumberOfChannelsKey 通道数 通常为双声道 值2
     2.AVSampleRateKey 采样率 单位HZ 通常设置成44100 也就是44.1k,采样率必须要设为11025才能使转化成mp3格式后不会失真
     3.AVLinearPCMBitDepthKey 比特率 8 16 24 32
     4.AVEncoderAudioQualityKey 声音质量
     ① AVAudioQualityMin  = 0, 最小的质量
     ② AVAudioQualityLow  = 0x20, 比较低的质量
     ③ AVAudioQualityMedium = 0x40, 中间的质量
     ④ AVAudioQualityHigh  = 0x60,高的质量
     ⑤ AVAudioQualityMax  = 0x7F 最好的质量
     5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps
     */
    
    //音频录制设置
    NSDictionary *settingsDic = @{
        AVFormatIDKey  :  @(kAudioFormatLinearPCM),
        AVSampleRateKey : @(11025.0),
        AVNumberOfChannelsKey :@2,
        AVEncoderBitDepthHintKey : @16,
        AVEncoderAudioQualityKey : @(AVAudioQualityHigh)
    };
    
    NSError *error = nil;
    self.audioRecorder_ = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:path] settings:settingsDic error:&error];
    self.audioRecorder_.delegate = self;
    //如果要监控声波则必须设置为YES
    self.audioRecorder_.meteringEnabled=YES;
    
    
    if (error) {
        NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
        return NO;
    }else{
        [self.audioRecorder_ record];
        return YES;
    }
    
    
}

#pragma mark - 结束录音

-(void)audioRecorderStopWitnCompletion:(AudioRecorderFinishedCompletionBlock)block{
    
    self.audioRecorderFinishedBlock = block;
    [self.audioRecorder_ stop];
}

#pragma mark - 录音 代理方法
/* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    NSLog(@"是否成功:%@",flag ? @"成功" : @"失败");
    
    if (self.audioRecorderFinishedBlock) {
        
        self.audioRecorderFinishedBlock(flag);
    }
    
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    
    NSLog(@"结束时错误error:%@",error.localizedDescription);
}

#pragma mark - 录音相关其他操作，开始，暂停，继续，结束
//- (void)record:(UIButton *)button {
//
//    if (![self.audioRecorder isRecording]) {
//        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
//        self.timer.fireDate = [NSDatedistantPast];
//    }
//}
//
//- (void)pause:(UIButton *)bu {
//    if ([self.audioRecorderisRecording]) {
//        [self.audioRecorderpause];
//        self.timer.fireDate=[NSDatedistantFuture];
//    }
//}
//
//
//- (void)resume:(UIButton *)bu {
//
//    [self record:bu];
//
//}

//- (void)stop:(UIButton *)bu {
//    [self.audioRecorderstop];
//    self.timer.fireDate=[NSDatedistantFuture];
//    self.audioPower.progress=0.0;
//}


#pragma mark - 机器语音播报
//语音播报
- (void)voiceAnnouncementsText:(NSString *)text WitnCompletion:(VoiceAnnouncementsFinishedCompletionBlock)block{
    
    self.voiceAnnouncementsFinishedBlock=block;
    
    //设置当前音频为播放状态
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    utterance.rate = 0.45;
//    utterance.pitchMultiplier = 1;
//    utterance.volume = 1;
//    utterance.preUtteranceDelay = 1;
//    utterance.postUtteranceDelay = 1;
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    utterance.voice = voice;
    
    [self.synthesizer speakUtterance:utterance];
    
    
    AVSpeechUtterance *uTTerance = [AVSpeechUtterance speechUtteranceWithString:@"tes-dd"];
    uTTerance.rate = 0.55;
    AVSpeechSynthesisVoice *voiced = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"];
    uTTerance.voice = voice;
    
}
//语音停止播报
-(void)voiceStopBroadcast{
    
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

//语音播报说完后的回调
-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    
    if (self.voiceAnnouncementsFinishedBlock) {
        
        self.voiceAnnouncementsFinishedBlock();
    }
    
}

-  (AVSpeechSynthesizer *)synthesizer
{
    if (!_synthesizer) {
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        _synthesizer.delegate=self;
    }
    return _synthesizer;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
