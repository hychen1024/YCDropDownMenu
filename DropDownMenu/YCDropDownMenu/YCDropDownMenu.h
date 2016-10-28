//
//  YCDropDownMenu.h
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/18.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCIndexPath.h"
#import "NSString+Size.h"
#import "YCColumnButton.h"

#define kNormalColor  [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.00]
#define kSelectColor  [UIColor colorWithRed:0.53 green:0.53 blue:0.53 alpha:1.00]
#define kLineColor  [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1.00]
#define kBackgroundColor  [UIColor whiteColor]
#define kFont(s) [UIFont systemFontOfSize:s]
#define kMaxSize CGSizeMake(MAXFLOAT, MAXFLOAT)

typedef enum{
    YCDropDownMenuColumnMainTableView                       = 0,
//    YCDropDownMenuColumnMainCollectionView                  = 1,
    YCDropDownMenuColumnMainCollectionViewInTableView       = 2,
    YCDropDownMenuColumnLeftRightTableView                  = 3,
//    YCDropDownMenuColumnLeftRightCollectionView             = 4,
//    YCDropDownMenuColumnLeftRightCollectionViewInTableView  = 5
}YCDropDownMenuColumnType;

@class YCDropDownMenu;
#pragma mark - 数据源方法
@protocol YCDropDownMenuDataSource <NSObject>
@required
- (NSInteger)numberOfColumnsInMenu:(YCDropDownMenu *)menu;
- (NSString *)YCDropDownMenu:(YCDropDownMenu *)menu titleForIndexPath:(YCIndexPath *)indexPath;
- (NSString *)YCDropDownMenu:(YCDropDownMenu *)menu titleForColumn:(NSInteger)column;
- (YCDropDownMenuColumnType)YCDropDownMenu:(YCDropDownMenu *)menu typeForColumn:(NSInteger)column;
- (NSInteger)YCDropDownMenu:(YCDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section InColumn:(NSInteger)column;
@optional
- (NSInteger)YCDropDownMenu:(YCDropDownMenu *)menu numberOfSectionsInColumn:(NSInteger)column;
// YES:开启左栏 NO:开启单栏分组
//- (BOOL)hasRightTableViewInColumn:(NSInteger)column;

// 左栏显示的比例 默认0.33
- (CGFloat)leftRatioWithRightInColumn:(NSInteger)column;
@end

#pragma mark - 代理方法
@protocol YCDropDownMenuDelegate <NSObject>
@optional
- (void)didSelectColumnInMenu:(YCDropDownMenu *)menu;
- (void)YCDropDownMenu:(YCDropDownMenu *)menu didSelectSectionAtColumn:(NSInteger)column;
- (void)YCDropDownMenu:(YCDropDownMenu *)menu didSelectRowAtIndexPath:(YCIndexPath *)indexPath;

@end



@interface YCDropDownMenu : UIView<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) id<YCDropDownMenuDelegate>   delegate;
@property (nonatomic, weak) id<YCDropDownMenuDataSource> dataSource;

//@property (nonatomic, strong) UIFont *topFont;
//@property (nonatomic, strong) UIFont *font;
//@property (nonatomic, strong) UIColor *normalTintColor;
//@property (nonatomic, strong) UIColor *selectedTintColor;

- (NSString *)titleForIndexPath:(YCIndexPath *)indexPath;

@end
