//
//  CRPerson.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/6/7.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRPerson.h"

@implementation CRPerson


- (instancetype)init{
    if(self = [super init]){
        self.name = @"name";
        self.age = 22;
        self.height = 177.3;
    }
    return self;
}


- (void)run{
//    NSLog(@"%s-%@",__FUNCTION__,[self class]);
    NSLog(@"%s-%@",__func__,[self class]);

}


- (void)test
{
    NSLog(@"test print name is : %@", self.name);
}
@end
