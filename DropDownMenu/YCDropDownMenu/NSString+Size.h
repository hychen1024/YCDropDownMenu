//
//  NSString+Size.h
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/19.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font MaxSize:(CGSize)size LineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)textSizeWithFont:(UIFont *)font MaxSize:(CGSize)size;
@end
