//
//  UserBuilder.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/21.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "UserBuilder.h"

@implementation UserBuilder

- (UserBuilder*)userID:(NSNumber*)userID {
    _userID = userID;
    return self;
}
- (UserBuilder*)userName:(NSString*)userName {
    _userName = userName;
    return self;
}
- (UserBuilder*)signature:(NSString*)signature {
    _signature = signature;
    return self;
}

@end
