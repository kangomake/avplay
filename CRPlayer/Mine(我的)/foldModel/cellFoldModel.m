//
//  cellFoldModel.m
//  CRPlayer
//
//  Created by appleDeveloper on 2021/7/22.
//  Copyright © 2021 appleDeveloper. All rights reserved.
//

#import "cellFoldModel.h"

@implementation cellFoldModel
- (instancetype)initWithHeight:(float)height{
    
    if(self = [super init]){
        self.cellHeight = height;
    }
    return self;
}
@end
