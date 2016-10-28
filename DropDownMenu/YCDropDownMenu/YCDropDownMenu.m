//
//  YCDropDownMenu.m
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/18.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import "YCDropDownMenu.h"

@interface YCDropDownMenu ()<YCColumnButtonDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selectedIndex;
    BOOL _isShowContentView;
}
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UICollectionView *mainCollectionView;

//底层背景
@property (nonatomic, strong) UIView *bgView;
//分割线
@property (nonatomic, strong) UIView *lineView;
//内容
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray *columnButtonArray;

@property (nonatomic, assign) NSInteger selectColumn;
@property (nonatomic, assign) NSInteger selectSection;
@property (nonatomic, assign) NSInteger selectRow;

@property (nonatomic, assign) NSInteger numOfColumn;
//数据源存储
@property (nonatomic, strong) NSMutableArray *sourceArray;


@end
@implementation YCDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI{

    self.autoresizesSubviews = NO;
    self.leftTableView.autoresizesSubviews = NO;
    self.mainTableView.autoresizesSubviews = NO;
    self.mainCollectionView.autoresizesSubviews = NO;
    
//    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
//    topLine.backgroundColor = kLineColor;
//    [self addSubview:topLine];
}

#pragma mark - 布局表格
- (void)initSubviewForColumn:(NSInteger)column DictData:(NSDictionary *)dict{
    
}

#pragma mark - TableView
#pragma mark - CollectionView

#pragma mark - 动画显示隐藏下拉菜单
- (void)showContentView{
    if (_isShowContentView) {
        //刷新ContentView高度并刷新表格
    }else{
        CGRect frame = self.contentView.frame;
        CGRect tmpFrame = frame;
        tmpFrame.size.height = 0;
        self.contentView.frame = tmpFrame;
        [[UIApplication sharedApplication].keyWindow addSubview:self.contentView];
        [UIView animateWithDuration:0.7 animations:^{
            self.contentView.frame = frame;
        }];
    }
}

- (void)hiddenContentView{
    CGRect frame = self.contentView.frame;
    frame.size.height = 0;
    [UIView animateWithDuration:0.7 animations:^{
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
    }];
}

- (void)animateLeftTableView:(UITableView *)leftTableView MainTableView:(UITableView *)mainTableView IsShow:(BOOL)isShow Complete:(void (^)())complete{
    
}

- (void)animateLeftTableView:(UITableView *)leftTableView MainCollectionView:(UICollectionView *)mainCollectionView IsShow:(BOOL)isShow Complete:(void (^)())complete{
    
}

#pragma mark - 动画显示隐藏遮罩背景
- (void)showBgCoverView{
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.alpha = 0.5;
    }];
}

- (void)hiddenBgCoverView{
    [UIView animateWithDuration:0.5 animations:^{
        self.bgView.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
    }];
}

#pragma mark - 按钮响应

#pragma mark - UITableView
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

#pragma mark - YCColumnButtonDelegate
- (void)YCColumnButton:(YCColumnButton *)button Index:(NSInteger)index IsSelected:(BOOL)selected{
    for (YCColumnButton *btn in self.columnButtonArray) {
        [btn hiddenMenu];
    }
    if (_selectedIndex != index) {
        [button showMenu];
    }else if (_selectedIndex == index && selected) {
        [button showMenu];
    }else{
        [button hiddenMenu];
    }
    _selectedIndex = index;
}

#pragma mark - setter
- (void)setDataSource:(id<YCDropDownMenuDataSource>)dataSource{
    _dataSource = dataSource;
    self.sourceArray = [NSMutableArray array];
    
    // 顶栏数
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        self.numOfColumn = [self.dataSource numberOfColumnsInMenu:self];
        NSAssert(self.numOfColumn != 0, @"numOfColumn can not be nil or 0!");
    }
    
    // 数据源
    for (int i = 0; i < self.numOfColumn; ++i) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        // 表格类型
        if ([self.dataSource respondsToSelector:@selector(YCDropDownMenu:typeForColumn:)]) {
            NSInteger type = [self.dataSource YCDropDownMenu:self typeForColumn:i];
            if (type) {
                [dict setValue:@(type) forKey:@"type"];
            }else{
                [dict setValue:@(0) forKey:@"type"];
            }
        }
        
        // Column名称
        if (self.columnButtonArray && self.columnButtonArray.count>0) {
            NSString *title = [self.columnButtonArray[i] valueForKey:@"title"];
            [dict setValue:title forKey:@"title"];
        }
        
        // Section
        if ([self.dataSource respondsToSelector:@selector(YCDropDownMenu:numberOfSectionsInColumn:)]) {
            NSInteger count = [self.dataSource YCDropDownMenu:self numberOfSectionsInColumn:i];
            [dict setValue:@(count) forKey:@"section"];
            
            // Row
            for (int j = 0; j < count; ++j) {
                if ([self.dataSource respondsToSelector:@selector(YCDropDownMenu:numberOfRowsInSection:InColumn:)]) {
                    NSInteger row_count = [self.dataSource YCDropDownMenu:self numberOfRowsInSection:j InColumn:i];
                    [dict setValue:@(row_count) forKey:@"row"];
                }
            }
        }else{
            [dict setValue:@(1) forKey:@"section"];
            
            // Row
            if ([self.dataSource respondsToSelector:@selector(YCDropDownMenu:numberOfRowsInSection:InColumn:)]) {
                NSInteger row_count = [self.dataSource YCDropDownMenu:self numberOfRowsInSection:0 InColumn:i];
                [dict setValue:@(row_count) forKey:@"row"];
            }
        }
        
        // 布局表格
        // dict: type,title,section,row
        [self initSubviewForColumn:i DictData:dict];
        
        [self.sourceArray addObject:dict];
    }
}

- (void)setNumOfColumn:(NSInteger)numOfColumn{
    _numOfColumn = numOfColumn;
    
    // 布局顶栏
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.numOfColumn; ++i) {
        if ([self.dataSource respondsToSelector:@selector(YCDropDownMenu:titleForColumn:)]) {
            NSString *title = [self.dataSource YCDropDownMenu:self titleForColumn:i];
            CGFloat buttonW = self.frame.size.width / self.numOfColumn;
            CGFloat buttonX = i * buttonW;
            CGFloat buttonY = 0;
            CGFloat buttonH = self.frame.size.height;
            YCColumnButton *button = [YCColumnButton buttonWithTitle:title Index:i Frame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
            if (i != self.numOfColumn-1) {
                [button setSeparateLine];
            }
            button.delegate = self;
            __weak typeof(self) weakSelf = self;
            [button columnButtonDidClickBlock:^(YCColumnButton *btn, NSInteger index, BOOL selected) {
#warning full show subTableView/CollectionView
                if (selected) {
                    NSLog(@"弹出");
                    [self showBgCoverView];
                    [self showContentView];
                }else{
                    NSLog(@"隐藏");
                    [self hiddenBgCoverView];
                    [self hiddenContentView];
                }
            }];
            [self addSubview:button];
            [tmpArray addObject:button];
        }else{
            
        }
    }
    self.columnButtonArray = tmpArray.copy;
}

#pragma mark - getter
- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, 0, 0) style:UITableViewStyleGrouped];
        _leftTableView.rowHeight = 40;
        _leftTableView.separatorColor = [UIColor colorWithRed:220.f/255.0f green:220.f/255.0f blue:220.f/255.0f alpha:1.0];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height, 0, 0) style:UITableViewStyleGrouped];
        _leftTableView.rowHeight = 40;
        _leftTableView.separatorColor = [UIColor colorWithRed:220.f/255.0f green:220.f/255.0f blue:220.f/255.0f alpha:1.0];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _mainTableView;
}

- (UICollectionView *)mainCollectionView{
    if (_mainTableView) {
        
    }
    return _mainCollectionView;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        CGFloat bgViewY = self.frame.origin.y+self.frame.size.height;
        _bgView.frame = CGRectMake(0, bgViewY+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-bgViewY);
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBgCoverView)];
        _bgView.userInteractionEnabled = YES;
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
        _lineView.backgroundColor = [UIColor lightTextColor];
    }
    return _lineView;
}

- (NSArray *)columnButtonArray{
    if (!_columnButtonArray) {
        _columnButtonArray = [NSArray array];
    }
    return _columnButtonArray;
}

- (NSString *)titleForIndexPath:(YCIndexPath *)indexPath{
    return [self.dataSource YCDropDownMenu:self titleForIndexPath:indexPath];
}

@end
