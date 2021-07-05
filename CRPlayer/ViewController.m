//
//  ViewController.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/6/9.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "ViewController.h"
#import "GTVideoCoverCell.h"

#import <objc/runtime.h>
#import "YYFPSLabel.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //流式布局，itemSize设置
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width / 16 * 9 + 60);

    //collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    //inset自动适配
    //collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    collectionView.delegate = self;
    collectionView.dataSource = self;

    //注册Item class
    [collectionView registerClass:[GTVideoCoverCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];

    [self.view addSubview:collectionView];
    
//    [self performSelector:@selector(fun)];
    
//    [self SwizzlingMethod];
//    [self originalFunction];
//    [self swizzledFunction];
    
    [self printIvarList];
    [self printMethodList_view];
    
    [self testFPSLabel];
    // Do any additional setup after loading the view.
}

//FPS帧率测试
- (void)testFPSLabel{
    
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(20, 100, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
    
}

- (void)printIvarList{
    unsigned int count;
    
    Ivar *ivarList = class_copyIvarList([UIViewController class], &count);
    for(unsigned int i = 0;i<count;i++){
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"ivar(%d):%@",i,[NSString stringWithUTF8String:ivarName]);
    }
    
    free(ivarList);
    
}

- (void)printMethodList{
    unsigned int count;
    
    Method *methodList = class_copyMethodList([UIViewController class], &count);
    for(unsigned int i = 0;i<count;i++){
        Method method = methodList[i];
        NSLog(@"method(%d):%@",i,NSStringFromSelector(method_getName(method)));
    }
    
    free(methodList);
}

- (void)printMethodList_view{
    
    unsigned int count_;
    
    Method *methodList_ = class_copyMethodList([UIView class], &count_);
    for(unsigned int i = 0;i<count_;i++){
        Method method = methodList_[i];
        NSLog(@"view_method(%d):%@",i,NSStringFromSelector(method_getName(method)));
    }
    
}



- (void)SwizzlingMethod{
    // 当前类
    Class class = [self class];
    
    // 原方法名 和 替换方法名
    SEL originalSelector = @selector(originalFunction);
    SEL swizzledSelector = @selector(swizzledFunction);
    
    // 原方法结构体 和 替换方法结构体
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 调用交换两个方法的实现
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
}

- (void)originalFunction{
    NSLog(@"originalFunction");
}

- (void)swizzledFunction{
    NSLog(@"swizzledFunction");
}

#pragma mark -- runtime 1.消息转发
/*
 运行时消息转发阶段：
 动态解析：通过重写 +resolveInstanceMethod: 或者 +resolveClassMethod:方法，利用 class_addMethod方法添加其他函数实现；
 消息接受者重定向：如果上一步没添加其他函数实现，可在当前对象中利用 forwardingTargetForSelector: 方法将消息的接受者转发给其他对象；
 消息重定向：如果上一步没有返回值为 nil，则利用 methodSignatureForSelector:方法获取函数的参数和返回值类型。
 如果 methodSignatureForSelector: 返回了一个 NSMethodSignature 对象（函数签名），Runtime 系统就会创建一个 NSInvocation 对象，并通过 forwardInvocation: 消息通知当前对象，给予此次消息发送最后一次寻找 IMP 的机会。
 如果 methodSignatureForSelector: 返回 nil。则 Runtime 系统会发出 doesNotRecognizeSelector: 消息，程序也就崩溃了。
 
 */

// 1.消息动态解析
//重写 resolveInstanceMethod: 添加对象方法实现
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
//    if(sel == @selector(fun)){// 如果是执行 fun 函数，就动态解析，指定新的 IMP
//        class_addMethod([self class], sel, (IMP)funMethod, "v@:");
        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
}

//void funMethod(id obj, SEL _cmd){
//    NSLog(@"add method");
//}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    
//    if(aSelector == @selector(fun)){
//        return [[GTVideoCoverCell alloc]init];// 返回 GTVideoCoverCell 对象，  让GTVideoCoverCell 对象接收这个消息
//    }
//    return [super forwardingTargetForSelector:aSelector];
    return nil;
}



//获取函数的参数和返回值类型，返回签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if([NSStringFromSelector(aSelector) isEqualToString:@"fun"]){
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    SEL sel = anInvocation.selector;// 从 anInvocation 中获取消息
    
    GTVideoCoverCell *cell = [[GTVideoCoverCell alloc]init];
    if([cell respondsToSelector:sel]){// 判断 GTVideoCoverCell 对象方法是否可以响应 sel
        [anInvocation invokeWithTarget:cell];// 若可以响应，则将消息转发给其他对象处理
    }else{
        [self doesNotRecognizeSelector:sel];// 若仍然无法响应，则报错：找不到响应方法
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //需要返回数据个数
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    if ([cell isKindOfClass:[GTVideoCoverCell class]]) {
        //方便讲解事例数据
//        [(GTVideoCoverCell *)cell layoutWithVideoCoverUrl:@"videoCover" videoUrl:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
        
        [(GTVideoCoverCell *)cell layoutWithVideoCoverUrl:@"videoCover" videoUrl:@"shanghaiwaitan.mp4"];
        
    }
    return cell;
}

@end
