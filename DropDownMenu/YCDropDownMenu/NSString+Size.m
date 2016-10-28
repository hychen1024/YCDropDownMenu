//
//  NSString+Size.m
//  YCDropDownMenu
//
//  Created by Just-h on 16/10/19.
//  Copyright © 2016年 JUST-Hychen. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font MaxSize:(CGSize)size LineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        textSize = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }else{
        textSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    return textSize;
}

- (CGSize)textSizeWithFont:(UIFont *)font MaxSize:(CGSize)size{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}
@end
