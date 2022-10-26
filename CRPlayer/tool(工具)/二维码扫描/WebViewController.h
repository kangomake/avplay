//
//  WebViewController.h
//  hr_renzheng
//
//  Created by appleDeveloper on 2021/4/20.
//

#import "RefreshViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewController : RefreshViewController

@property (nonatomic, copy) NSString * urlStr;
@property (nonatomic, copy) NSString * titleStr;

@end

NS_ASSUME_NONNULL_END
