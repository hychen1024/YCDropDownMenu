//
//  YCColumnButton.m
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/19.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import "YCColumnButton.h"
#import "YCDropDownMenu.h"

NSInteger const kIndicatorW = 15;
NSInteger const kLeftPadding = 10;
NSInteger const kFontSize = 15;

@interface YCColumnButton ()
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *indicateView;
@property (nonatomic, strong) UIView *lineView;
// 绘制底部实线
@property (nonatomic, strong) CAShapeLayer *solidShapeLayer;

@property (nonatomic, assign) NSInteger index;

@end
@implementation YCColumnButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.selected = NO;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLb];
        [self addSubview:self.indicateView];
        [self addSubview:self.lineView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidClick:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title Index:(NSInteger)index Frame:(CGRect)frame{
    self = [self initWithFrame:frame];
    if (self) {
        self.title = title;
        self.index = index;
    }
    return self;
}

+ (instancetype)buttonWithTitle:(NSString *)title Index:(NSInteger)index Frame:(CGRect)frame{
    YCColumnButton *button = [[YCColumnButton alloc] initWithTitle:title Index:index Frame:frame];
    return button;
}

#pragma mark - 响应
- (void)buttonDidClick:(UITapGestureRecognizer *)tap{
    if (!self.selected) {
        //展开
        if (self.columnButtonBlock) {
            self.columnButtonBlock(self,self.index,YES);
        }
        if ([self.delegate respondsToSelector:@selector(YCColumnButton:Index:IsSelected:)]) {
            [self.delegate YCColumnButton:self Index:self.index IsSelected:YES];
        }
    }else{
        //收缩
        if (self.columnButtonBlock) {
            self.columnButtonBlock(self,self.index,NO);
        }
        if ([self.delegate respondsToSelector:@selector(YCColumnButton:Index:IsSelected:)]) {
            [self.delegate YCColumnButton:self Index:self.index IsSelected:NO];
        }
    }
//    self.selected = !self.selected;
}
#pragma mark - 自定义
- (void)showMenu{
    self.selected = YES;
    self.titleLb.textColor = kSelectColor;
    self.indicateView.highlighted = YES;
    //选中分割线
    [self selectLine];
}

- (void)hiddenMenu{
    self.selected = NO;
    self.titleLb.textColor = kNormalColor;
    self.indicateView.highlighted = NO;
    //正常分割线
    [self normalLine];
}

- (void)columnButtonDidClickBlock:(ColumnButtonBlock)block{
    self.columnButtonBlock = block;
}
#pragma mark - 顶栏分割线
- (void)normalLine{

    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [self.solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [self.solidShapeLayer setStrokeColor:[kLineColor CGColor]];
    self.solidShapeLayer.lineWidth = 0.5f;
    CGPathMoveToPoint(solidShapePath, NULL, 0, self.lineView.frame.size.height-0.5);
    CGPathAddLineToPoint(solidShapePath, NULL, self.lineView.frame.size.width,self.lineView.frame.size.height-0.5);
    [self.solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.lineView.layer addSublayer:self.solidShapeLayer];
    
}

- (void)selectLine{
    
    CGMutablePathRef solidShapePath = CGPathCreateMutable();
    [self.solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [self.solidShapeLayer setStrokeColor:[kLineColor CGColor]];
    self.solidShapeLayer.lineWidth = 0.5f;
    CGPathMoveToPoint(solidShapePath, NULL, 0, self.lineView.frame.size.height-0.5);
    CGPathAddLineToPoint(solidShapePath, NULL, self.lineView.frame.size.width*0.5-5, self.lineView.frame.size.height-0.5);
    CGPathAddLineToPoint(solidShapePath, NULL, self.lineView.frame.size.width*0.5, self.lineView.frame.size.height-7);
    CGPathAddLineToPoint(solidShapePath, NULL, self.lineView.frame.size.width*0.5+5, +self.lineView.frame.size.height-0.5);
    CGPathAddLineToPoint(solidShapePath, NULL, self.lineView.frame.size.width, self.lineView.frame.size.height-0.5);
    [self.solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [self.lineView.layer addSublayer:self.solidShapeLayer];

}

#pragma mark - setter
- (void)setSeparateLine{
    CAShapeLayer *verticalShape = [CAShapeLayer layer];
    CGMutablePathRef verticalPath = CGPathCreateMutable();
    [verticalShape setFillColor:[[UIColor clearColor] CGColor]];
    [verticalShape setStrokeColor:[[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.00] CGColor]];
    verticalShape.lineWidth = 0.2f;
    CGPathMoveToPoint(verticalPath, NULL, self.frame.size.width-1, self.frame.size.height * 0.25);
    CGPathAddLineToPoint(verticalPath, NULL, self.frame.size.width-1, self.frame.size.height*0.75);
    [verticalShape setPath:verticalPath];
    CGPathRelease(verticalPath);
    [self.layer addSublayer:verticalShape];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
    CGSize textSize = [title textSizeWithFont:kFont(kFontSize) MaxSize:kMaxSize LineBreakMode:0];
    _titleLb.frame = CGRectMake((self.frame.size.width - textSize.width*1.15 - kIndicatorW)*0.5, (self.frame.size.height - textSize.height)*0.5, textSize.width*1.15, textSize.height);
    _indicateView.frame = CGRectMake((self.frame.size.width - textSize.width*1.15 - kIndicatorW)*0.5+textSize.width*1.15, (self.frame.size.height-kIndicatorW)*0.5, kIndicatorW, kIndicatorW);

}

#pragma mark - getter
- (UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = kNormalColor;
        _titleLb.font = kFont(kFontSize);
    }
    return _titleLb;
}

- (UIImageView *)indicateView{
    if (!_indicateView) {
        _indicateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top"] highlightedImage:[UIImage imageNamed:@"down"]];
    }
    return _indicateView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.frame = CGRectMake(0, self.frame.size.height - 5, self.frame.size.width, 8);
        _lineView.backgroundColor = [UIColor clearColor];
        [self normalLine];
    }
    return _lineView;
}

- (CAShapeLayer *)solidShapeLayer{
    if (!_solidShapeLayer) {
        _solidShapeLayer = [CAShapeLayer layer];
    }
    return _solidShapeLayer;
}
@end
