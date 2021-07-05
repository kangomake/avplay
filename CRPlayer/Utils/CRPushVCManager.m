//
//  CRPushVCManager.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/23.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRPushVCManager.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation CRPushVCManager





+ (void)push:(NSDictionary *)params controller:(nonnull UIViewController *)controller{
    // 类名
    NSString *class = [NSString stringWithFormat:@"%@",params[@"class"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if(!newClass){
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    NSDictionary *propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       // 检测这个对象是否存在该属性
        if([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]){
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
        
    }];
    
    
    //获取导航控制器
//    UITabBarController *tabVC = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
//
//    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
//    // 跳转到对应的控制器
//    [pushClassStance pushViewController:instance animated:YES];
    
    if(controller && [controller isKindOfClass:[UIViewController class]]){
        [controller.navigationController pushViewController:instance animated:YES];
    }
    
    
}

// 检测对象是否存在该属性
+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName{
    
    unsigned int outCount, i;
    // 获取对象里的属性列表
    objc_property_t *properties = class_copyPropertyList([instance class], &outCount);
    
    for(i = 0;i<outCount;i++){
        objc_property_t property = properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if([propertyName isEqualToString:verifyPropertyName]){
            free(properties);
            return YES;
        }
        
    }
    free(properties);

    return NO;
        
}

@end
