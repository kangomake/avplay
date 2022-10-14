//
//  NameSorting.h
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/14.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NameSorting : NSObject

+(NSDictionary *)nameSortWithObjctArr:(NSArray *)objctArr BasisFirstKeyString:(NSString *)firstString  andSecondKeyString:(NSString *)secondString;

@end

NS_ASSUME_NONNULL_END
