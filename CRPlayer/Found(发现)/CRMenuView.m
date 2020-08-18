//
//  CRMenuView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/8/17.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRMenuView.h"


static CGFloat const kCellHeight = 55;


@interface CRMenuView () <UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, assign) CGPoint trianglePoint;
@property (nonatomic, copy) void (^action)(NSInteger index);

@end


@implementation CRMenuView


+ (void)initWithItems:(NSArray *)ItemArray
             picArray:(NSArray *)picArray
                width:(CGFloat)width
             Location:(CGPoint)point
               action:(void(^)(NSInteger index))action{
    
    CRMenuView * menuView = [[CRMenuView alloc] initWithItems:ItemArray picArray:picArray width:width Location:point action:action];
    [menuView show];
    
    
}


- (instancetype)initWithItems:(NSArray *)ItemArray
                     picArray:(NSArray *)picArray
                        width:(CGFloat)width
                     Location:(CGPoint)point
                       action:(void(^)(NSInteger index))action{
    
    if(ItemArray.count == 0) return nil;
    if(self = [super init]){
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.alpha = 0;
        self.tableData = [ItemArray copy];
        self.picArray = [picArray copy];
        self.trianglePoint = point;
        self.action = action;
        
        [self addGestureRecognizer:({
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureTap)];
            tap.delegate = self;
            tap;
        })];
        
        
        // 创建tableView
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(point.x, point.y + 5, width, kCellHeight * ItemArray.count) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.masksToBounds = YES;
        _tableView.separatorColor = [UIColor grayColor];
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = kCellHeight;
        [self addSubview:_tableView];
        
        
    }
    
    return self;
    
}

#pragma mark -- prive

- (void)hide{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 0;
        self.tableView.transform = CGAffineTransformMakeScale(0.001, 0.001);
        
    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
    
}

- (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _tableView.layer.position = CGPointMake(_trianglePoint.x, _trianglePoint.y);
    _tableView.layer.anchorPoint = CGPointMake(0, 1);
    _tableView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
        _tableView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }];
    
}

- (void)GestureTap{
    [self hide];
}


#pragma mark --- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]){
        return NO;
    }
    
    return YES;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopMenuTableViewCell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PopMenuTableViewCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PopMenuTableViewCell"];
    }
    NSString * str = _tableData[indexPath.row];
    cell.textLabel.text = str;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self hide];
    if (_action) {
        _action(indexPath.row);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
