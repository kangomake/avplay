//
//  CRTagListView.m
//  CRPlayer
//
//  Created by appleDeveloper on 2020/9/1.
//  Copyright © 2020 appleDeveloper. All rights reserved.
//

#import "CRTagListView.h"
#import "CRButton.h"


CGFloat const imageViewWH = 6;


@interface CRTagListView(){
    
    NSMutableArray *_tagArray;
    
}

//@property (nonatomic, weak) UICollectionView *tagListView;
@property (nonatomic, strong) NSMutableDictionary *tags;
@property (nonatomic, strong) NSMutableArray *tagButtons;


@end


@implementation CRTagListView

- (NSMutableArray *)tagArray{
    
    if(_tagArray == nil){
        _tagArray = [[NSMutableArray alloc]init];
    }
    return _tagArray;
    
}

- (NSMutableArray *)tagButtons{
    
    if(!_tagButtons){
        _tagButtons = [[NSMutableArray alloc]init];
    }
    return _tagButtons;
    
}

- (NSMutableDictionary *)tags
{
    if (_tags == nil) {
        _tags = [NSMutableDictionary dictionary];
    }
    return _tags;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

#pragma mark --- init

- (void)setup{
    _tagMargin = 10;
    _tagColor = [UIColor orangeColor];
    _tagButtonMargin = 10;
    _tagCornerRadius = 15;
    _borderWidth = 0.5;
    _borderColor = _tagColor;
    _tagListCols = 4;
    _isFitTagListH = YES;

    _tagFont = [UIFont systemFontOfSize:12];
    self.clipsToBounds = YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    _tagListView.frame = self.bounds;
}

- (CGFloat)tagListH
{
    if (self.tagButtons.count <= 0) return 0;
    return CGRectGetMaxY([self.tagButtons.lastObject frame]) + _tagMargin;
}

#pragma mark --操作标签方法
- (void)addTags:(NSArray *)tagStrs{
    
    if(tagStrs.count == 0){//add
        return;
    }
    
    if (self.frame.size.width == 0) {
        @throw [NSException exceptionWithName:@"YZError" reason:@"先设置标签列表的frame" userInfo:nil];
    }
    
    for (NSString *tagStr in tagStrs) {
        [self addTag:tagStr];
    }
    
    
}

- (void)addTag:(NSString *)tagStr{
    
    if(!tagStr){
        return;
    }
    
    if(tagStr && tagStr.length == 0){//add
        return;
    }
    
    // 创建标签按钮
    CRButton *tagButton = [CRButton buttonWithType:UIButtonTypeCustom];
    tagButton.margin = _tagButtonMargin;
    tagButton.layer.cornerRadius = 15;
    tagButton.layer.borderWidth = 0.5;
    tagButton.layer.borderColor = [UIColor orangeColor].CGColor;
    tagButton.clipsToBounds = YES;
    tagButton.tag = self.tagButtons.count;
    [tagButton setImage:_tagDeleteimage forState:UIControlStateNormal];
    [tagButton setTitle:tagStr forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [tagButton setBackgroundColor:[UIColor whiteColor]];
    [tagButton setBackgroundImage:_tagBackgroundImage forState:UIControlStateNormal];
    tagButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [tagButton addTarget:self action:@selector(clickTag:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tagButton];
    
    // 保存到数组
    [self.tagButtons addObject:tagButton];
    
    // 保存到字典
    [self.tags setObject:tagButton forKey:tagStr];
    [self.tagArray addObject:tagStr];
    
    // 设置按钮的位置
    [self updateTagButtonFrame:tagButton.tag extreMargin:YES];
    
    // 更新自己的高度
    if (_isFitTagListH) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
    
}

// 点击标签
- (void)clickTag:(UIButton *)button
{
    
//    if (_clickTagBlock) {
//        _clickTagBlock(button.currentTitle);
//    }
    
    [self deleteTag:button.currentTitle];
    
}


- (void)removeAllTag{
    
    // 移除按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 移除数组
    [self.tagButtons removeAllObjects];
    
    // 移除字典
    [self.tags removeAllObjects];
    
    // 移除数组
    [self.tagArray removeAllObjects];
   
}


// 删除标签
- (void)deleteTag:(NSString *)tagStr
{
    
   if(!tagStr){
        return;
    }
    
    if(tagStr && tagStr.length == 0){//add
        return;
    }
    
    // 获取对应的标题按钮
    CRButton *button = self.tags[tagStr];
    
    // 移除按钮
    [button removeFromSuperview];
    
    // 移除数组
    [self.tagButtons removeObject:button];
    
    // 移除字典
    [self.tags removeObjectForKey:tagStr];
    
    // 移除数组
    [self.tagArray removeObject:tagStr];
    
    // 更新tag
    [self updateTag];
    
    // 更新后面按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateLaterTagButtonFrame:button.tag];
    }];
    
    // 更新自己的frame
    if (_isFitTagListH) {
        CGRect frame = self.frame;
        frame.size.height = self.tagListH;
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = frame;
        }];
    }
    
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMultiFunctionsForCP" object:tagStr userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMultiFeildsForCP" object:tagStr userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMultiPlaces" object:tagStr userInfo:nil];
   
   
}

// 更新标签
- (void)updateTag
{
    NSInteger count = self.tagButtons.count;
    for (int i = 0; i < count; i++) {
        UIButton *tagButton = self.tagButtons[i];
        tagButton.tag = i;
    }
}



// 更新以后按钮
- (void)updateLaterTagButtonFrame:(NSInteger)laterI
{
    NSInteger count = self.tagButtons.count;
    
    for (NSInteger i = laterI; i < count; i++) {
        // 更新按钮
        [self updateTagButtonFrame:i extreMargin:YES];
    }
}

- (void)updateTagButtonFrame:(NSInteger)i extreMargin:(BOOL)extreMargin
{
    // 获取上一个按钮
    NSInteger preI = i - 1;
    
    // 定义上一个按钮
    UIButton *preButton;
    
    // 过滤上一个角标
    if (preI >= 0) {
        preButton = self.tagButtons[preI];
    }
    
    // 获取当前按钮
    CRButton *tagButton = self.tagButtons[i];
    
    // 设置标签按钮frame（自适应）
    [self setupTagButtonCustomFrame:tagButton preButton:preButton extreMargin:extreMargin];
    
}

// 设置标签按钮frame（自适应）
- (void)setupTagButtonCustomFrame:(UIButton *)tagButton preButton:(UIButton *)preButton extreMargin:(BOOL)extreMargin
{
    
//    if(!tagButton){
//        return;
//    }
//
//
//    if(!preButton){
//        return;
//    }
//
//    
//    if(![tagButton isKindOfClass:[UIButton class]]){
//        return;
//    }
//
//    if(![preButton isKindOfClass:[UIButton class]]){
//        return;
//    }
    
    
    // 等于上一个按钮的最大X + 间距
    CGFloat btnX = CGRectGetMaxX(preButton.frame) + _tagMargin;
    
    // 等于上一个按钮的Y值,如果没有就是标签间距
    CGFloat btnY = preButton? preButton.frame.origin.y : _tagMargin;
    
    
    CGFloat titleW = [tagButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_tagFont}].width;
    CGFloat titleH = [tagButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:_tagFont}].height;
    
    CGFloat btnW = extreMargin?titleW + 2 * _tagButtonMargin : tagButton.bounds.size.width;
    if (_tagDeleteimage && extreMargin == YES) {
        btnW += imageViewWH;
        btnW += _tagButtonMargin;
    }
    
    // 获取按钮高度
    CGFloat btnH = extreMargin? titleH + 2 * _tagButtonMargin:tagButton.bounds.size.height;
    if (_tagDeleteimage && extreMargin == YES) {
        CGFloat height = imageViewWH > titleH ? imageViewWH : titleH;
        btnH = height + 2 * _tagButtonMargin;
    }
    
    // 判断当前按钮是否足够显示
    CGFloat rightWidth = self.bounds.size.width - btnX;
    
    if (rightWidth < btnW) {
        // 不够显示，显示到下一行
        btnX = _tagMargin;
        btnY = CGRectGetMaxY(preButton.frame) + _tagMargin;
    }
    
    tagButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

- (void)runLoop_text{
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
