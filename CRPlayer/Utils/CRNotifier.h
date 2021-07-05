//
//  CRNotifier.h
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/16.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRNotifier : NSObject

- (void)start:(NSString *)text;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
