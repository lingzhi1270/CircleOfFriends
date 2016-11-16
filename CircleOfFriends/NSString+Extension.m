//
//  NSString+Extension.m
//  CircleOfFriends
//
//  Created by lingzhi on 2016/11/7.
//  Copyright © 2016年 lingzhi. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

//高度自适应
//- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
//{
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = font;
//    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
//    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//    
//}

//宽度自适应
- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxH);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

}

@end
