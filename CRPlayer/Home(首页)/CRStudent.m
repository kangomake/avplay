//
//  CRStudent.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/6/7.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "CRStudent.h"

@implementation CRStudent

- (instancetype)init{
    if(self = [super init]){
//        NSLog(@"%@ - %@",[self class],[super class]);
//        NSLog(@"%@ - %@",[self superclass],[super superclass]);

    }
    return self;
}

- (void)study{
    NSLog(@"%s",__FUNCTION__);
}

- (void)run{

    [super run];

    NSLog(@"%s-%@",__func__,[self class]);

//    NSLog(@"%s-%@",__FUNCTION__,[self class]);
}

@end
