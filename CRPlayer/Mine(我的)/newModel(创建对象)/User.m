//
//  User.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/21.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUserBuilder:(UserBuilder*)builder {
    self = [super init];
    if (!self) {
        return nil;
    }

    _userID = builder.userID;
    _userName = builder.userName;
    _signature = builder.signature;
    return self;
}

@end
