//
//  CRAVPlayer.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/7.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRAVPlayer : UIView


- (instancetype)initWithFrame:(CGRect)frame Url:(NSString *)url;
- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)URL;


@end

NS_ASSUME_NONNULL_END
