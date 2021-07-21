//
//  UserBuilder.h
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/21.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserBuilder : NSObject

@property (nonatomic, strong, readonly) NSNumber*   userID;
@property (nonatomic, strong, readonly) NSString*   userName;
@property (nonatomic, strong, readonly) NSString*   signature;

- (UserBuilder*)userID:(NSNumber*)userID;
- (UserBuilder*)userName:(NSString*)userName;
- (UserBuilder*)signature:(NSString*)signature;

@end

/**
 UserBuilder* builder = [[[[UserBuilder new] userName:@"peak"] userID:@1000] signature:@"roll"];

 */

NS_ASSUME_NONNULL_END
