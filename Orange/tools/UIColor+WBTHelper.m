//
//  UIColor+WBTHelper.m
//  WBTool
//
//  Created by kevin on 14-7-21.
//  Copyright (c) 2014年 Sina. All rights reserved.
//

#import "UIColor+WBTHelper.h"
UIColor *wbt_UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue)
{
	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
}

UIColor *wbt_UIColorMakeRGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

@implementation UIColor (WBTHelper)

+ (CGFloat)wbt_redColorFromHexRGBColor:(NSInteger)color {
    return (((color & 0xff0000) >> 16) / 255.0);
}

+ (CGFloat)wbt_greenColorFromRGBColor:(NSInteger)color {
    return (((color & 0x00ff00) >> 8) / 255.0);
}

+ (CGFloat)wbt_blueColorFromRGBColor:(NSInteger)color {
    return ((color & 0x0000ff) / 255.0);
}

+ (UIColor *)wbt_colorWithHexValue:(NSInteger)color alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:[UIColor wbt_redColorFromHexRGBColor:color]
                           green:[UIColor wbt_greenColorFromRGBColor:color]
                            blue:[UIColor wbt_blueColorFromRGBColor:color]
                           alpha:alpha];
}

- (void)wbt_getColorComponentsWithRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:red green:green blue:blue alpha:alpha];
    }else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        *red = components[0];
        *green = components[1];
        *blue = components[2];
        *alpha = components[3];
    }
}

@end
