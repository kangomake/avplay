//
//  GTVideoPlayer.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/6/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoPlayer : NSObject

/**
 全局播放器单例
 */
+ (GTVideoPlayer *)Player;

/**
 在指定View上 通过url播放视频
 */
- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

- (void)videoStop;

@end

NS_ASSUME_NONNULL_END
