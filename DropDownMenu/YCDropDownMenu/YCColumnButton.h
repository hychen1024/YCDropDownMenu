//
//  YCColumnButton.h
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/19.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCColumnButton;

@protocol YCColumnButtonDelegate <NSObject>
@required
- (void)YCColumnButton:(YCColumnButton *)button Index:(NSInteger)index IsSelected:(BOOL)selected;
@end

typedef void(^ColumnButtonBlock)(YCColumnButton *btn,NSInteger index,BOOL selected);

@interface YCColumnButton : UIView

@property (nonatomic, copy) ColumnButtonBlock columnButtonBlock;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, weak) id<YCColumnButtonDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title Index:(NSInteger)index Frame:(CGRect)frame;
+ (instancetype)buttonWithTitle:(NSString *)title Index:(NSInteger)index Frame:(CGRect)frame;
- (void)columnButtonDidClickBlock:(ColumnButtonBlock)block;

- (void)showMenu;
- (void)hiddenMenu;

- (void)setSeparateLine;
@end
