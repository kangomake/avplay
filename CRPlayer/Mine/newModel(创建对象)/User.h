//
//  User.h
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/21.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, strong, readonly) NSNumber*  userID;
@property (nonatomic, strong, readonly) NSString*  userName;
@property (nonatomic, strong, readonly) NSString*  signature;

- (instancetype)initWithUserBuilder:(UserBuilder*)builder;


@end

/**
 如果要创建 User 对象，则按照这种方式：
 UserBuilder* builder = [[[[UserBuilder new] userName:@"peak"] userID:@1000] signature:@"roll"];
 User* user = [[User alloc] initWithUserBuilder:builder];
 
 */


NS_ASSUME_NONNULL_END
