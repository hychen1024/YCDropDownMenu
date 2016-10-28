//
//  ViewController.m
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/18.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import "ViewController.h"
#import "YCDropDownMenu.h"

@interface ViewController ()<YCDropDownMenuDataSource>
{
    NSArray *_titleArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = @[@"全部视频",@"综合排",@"筛选"];
    _titleArray = titleArray;
    
    YCDropDownMenu *menu = [[YCDropDownMenu alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 40)];
//    menu.backgroundColor = [UIColor redColor];
    menu.dataSource = self;
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfColumnsInMenu:(YCDropDownMenu *)menu{
    return 3;
}

- (NSInteger)YCDropDownMenu:(YCDropDownMenu *)menu numberOfRowsInSection:(NSInteger)section InColumn:(NSInteger)column{
    return 4;
}

- (YCDropDownMenuColumnType)YCDropDownMenu:(YCDropDownMenu *)menu typeForColumn:(NSInteger)column{
    return YCDropDownMenuColumnMainTableView;
}

- (NSInteger)YCDropDownMenu:(YCDropDownMenu *)menu numberOfSectionsInColumn:(NSInteger)column{
    return 1;
}

- (NSString *)YCDropDownMenu:(YCDropDownMenu *)menu titleForColumn:(NSInteger)column{
    return _titleArray[column];
}

@end
