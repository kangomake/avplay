//
//  NameSorting.m
//  CRPlayer
//
//  Created by appleDeveloper on 2022/10/14.
//  Copyright © 2022 appleDeveloper. All rights reserved.
//

#import "NameSorting.h"
#import "NSString+PinYin.h"

@implementation NameSorting

+(NSDictionary *)nameSortWithObjctArr:(NSArray *)objctArr BasisFirstKeyString:(NSString *)firstString  andSecondKeyString:(NSString *)secondString{
    
    NSMutableArray *namelistArrayM = [NSMutableArray array];
    
    //遍历所有数据 取出名字键值数组
    for(int i = 0; i < objctArr.count; i++){
        NSString *firstName = [objctArr[i] valueForKey:firstString];
        NSString *secondName = [objctArr[i] valueForKey:secondString];
        
        if(firstName.length > 0){
            [namelistArrayM addObject:firstName];
        }else{
            [namelistArrayM addObject:secondName];
        }
    }
    
    //将所有只有名字的数组 使用转换成拼音的
    NSArray *pinYinTempArr = [namelistArrayM arrayWithPinYinFirstLetterFormat];
    
    NSMutableArray *indexesListArrM = [NSMutableArray array];
    NSMutableArray *objcIndexesListArrM = [NSMutableArray array];
    
    NSInteger pinYinTempArrCount = pinYinTempArr.count;
    NSInteger objctArrCount = objctArr.count;
    
    for (int i = 0; i < pinYinTempArrCount; i++){
        NSDictionary *pinYinTempDic = pinYinTempArr[i];
        
        //分离出首字母,索引数组
        [indexesListArrM addObject:pinYinTempDic[@"firstLetter"]];
        NSArray *objcNameStrArr = pinYinTempDic[@"content"];
        
        NSMutableArray *tempAddObjctArrM = [NSMutableArray array];
        
        for (int i = 0;i < objcNameStrArr.count;i ++) {
            
            for (int j = 0;j < objctArrCount; j ++) {
                
                if ([objcNameStrArr[i] isEqualToString:[objctArr[j] valueForKey:firstString]]||[objcNameStrArr[i] isEqualToString:[objctArr[j] valueForKey:secondString]]) {
                    
                    [tempAddObjctArrM addObject:objctArr[j]];
                    
                }
                
            }
            
        }
        
        [objcIndexesListArrM addObject:tempAddObjctArrM];
        
    }
    
    
    NSDictionary *sortDic=@{
                            @"indexesListArrM":indexesListArrM,
                            @"objcIndexesListArrM":objcIndexesListArrM
                            };
    
    
    return sortDic;
    
    
}

@end
