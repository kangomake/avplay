//
//  CRPerson.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/6/7.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRPerson : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) float height;



- (void)run;
- (void)test;
@end

NS_ASSUME_NONNULL_END
