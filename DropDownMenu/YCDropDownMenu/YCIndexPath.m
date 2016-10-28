//
//  YCIndexPath.m
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/18.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import "YCIndexPath.h"

@implementation YCIndexPath

+ (instancetype)indexPathWithColumn:(NSInteger)column Section:(NSInteger)section Row:(NSInteger)row{
    YCIndexPath *indexPath = [[YCIndexPath alloc] initWithColumn:column Section:section Row:row];
    return indexPath;
}

- (instancetype)initWithColumn:(NSInteger)column Section:(NSInteger)section Row:(NSInteger)row{
    self = [super init];
    if (self) {
        self.column = column;
        self.section = section;
        self.row = row;
    }
    return self;
}
@end
