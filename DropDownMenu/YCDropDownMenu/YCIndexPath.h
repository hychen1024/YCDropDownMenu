//
//  YCIndexPath.h
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/18.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCIndexPath : NSObject
//顶栏
@property (nonatomic, assign) NSInteger column;
//组栏
@property (nonatomic, assign) NSInteger section;

@property (nonatomic, assign) NSInteger row;

- (instancetype)initWithColumn:(NSInteger)column
                       Section:(NSInteger)section
                           Row:(NSInteger)row;

+ (instancetype)indexPathWithColumn:(NSInteger)column
                            Section:(NSInteger)section
                                Row:(NSInteger)row;
@end
