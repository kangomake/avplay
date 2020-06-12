//
//  GTVideoCoverCell.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/6/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoCoverCell : UICollectionViewCell
/**
 根据数据布局，封面图&播放 url
 */
- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;

- (void)fun;

@end

NS_ASSUME_NONNULL_END
