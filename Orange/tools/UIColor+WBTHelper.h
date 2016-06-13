//
//  UIColor+WBTHelper.h
//  WBTool
//
//  Created by kevin on 14-7-21.
//  Copyright (c) 2014年 Sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 * 根据传入的RGB值，生成并返回对应的UIColor
 *
 * @param r      R
 * @param g      G
 * @param b      B
 *
 * @return  根据RGB值生成的UIColor对象
 */
#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#endif

/*!
 * 根据传入的RGBA值，生成并返回对应的UIColor
 *
 * @param r      R
 * @param g      G
 * @param b      B
 * @param a      A
 *
 * @return  根据RGBA值生成的UIColor对象
 */
#ifndef RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif

/*!
 * 将传入的RGB值转换成float
 *
 * @param r      R
 * @param g      G
 * @param b      B
 * @param a      A
 *
 * @return  返回对应传入RGB值的float值,和a值
 */
#ifndef RGBA
#define RGBA(r,g,b,a) r/255.0, g/255.0, b/255.0, a
#endif


/*!
 * 根据传入的RGBA值，alpha值默认为1，生成并返回对应的UIColor(RGBA色值的取值范围为0~1)
 *
 * @param r      红色色彩值
 * @param g      绿色色彩值
 * @param b      蓝色色彩值
 *
 * @return  根据RGBA值生成的UIColor对象
 */
#define FLOATRGBCOLOR(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1]
/*!
 * 根据传入的RGBA值，alpha值默认为1，生成并返回对应的CGColor对象(RGBA色值的取值范围为0~1)
 *
 * @param r      红色色彩值
 * @param g      绿色色彩值
 * @param b      蓝色色彩值
 *
 * @return  根据RGBA值生成的CGColor对象
 */
#define FLOATRGBCGCOLOR(r,g,b) [UIColor colorWithRed:r green:g blue:b alpha:1].CGColor

/*!
 * 根据传入的RGBA值以及alpha值，生成并返回对应的UIColor(RGBA色值的取值范围为0~1)
 *
 * @param r      红色色彩值
 * @param g      绿色色彩值
 * @param b      蓝色色彩值
 * @param a      透明值
 *
 * @return  根据RGBA值以及alpha值生成的UIColor对象
 */
#define FLOATRGBACOLOR(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]
/*!
 * 根据传入的RGBA值及alpha值，生成并返回对应的CGColor对象(RGBA色值的取值范围为0~1)
 *
 * @param r      红色色彩值
 * @param g      绿色色彩值
 * @param b      蓝色色彩值
 * @param a      透明值
 *
 * @return  根据RGBA值以及alpha值生成的CGColor对象
 */
#define FLOATRGBACGCOLOR(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a].CGColor

/*!
 * 根据传入的HSV值，生成并返回对应的CGColor对象(RGBA色值的取值范围为0~1)
 *
 * @param h      The hue component of the color object in the HSB color space, specified as a value from 0.0 to 1.0.
 * @param s      The saturation component of the color object in the HSB color space, specified as a value from 0.0 to 1.0.
 * @param v      The brightness (or value) component of the color object in the HSB color space, specified as a value from 0.0 to 1.0.
 *
 * @return  根据HSV值以及alpha值生成的CGColor对象
 */
#define HSVCOLOR(h,s,v) [UIColor colorWithHue:h saturation:s value:v alpha:1]

/*!
 * 根据传入的HSVA值及alpha值，生成并返回对应的CGColor对象(RGBA色值的取值范围为0~1)
 *
 * @param h      The hue component of the color object in the HSB color space, specified as a value from 0.0 to 1.0.
 * @param s      The saturation component of the color object in the HSB color space, specified as a value from 0.0 to 1.0.
 * @param v      The brightness (or value) component of the color object in the HSB color space, specified as a value from 0.0 to 1.0.
 * @param a      The opacity value of the color object, specified as a value from 0.0 to 1.0.
 *
 * @return  根据HSVA值以及alpha值生成的CGColor对象
 */
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:h saturation:s value:v alpha:a]

/*!
 *  根据RGB值，生成并返回一个UIColor对象
 *
 *  @param red   r
 *  @param green g
 *  @param blue  b
 *
 *  @return 创建的UIColor对象
 */
UIColor *wbt_UIColorMakeRGB(CGFloat red, CGFloat green, CGFloat blue);

/*!
 *  根据RGBA值，生成并返回一个UIColor对象
 *
 *  @param red   r
 *  @param green g
 *  @param blue  b
 *  @param alpha a
 *
 *  @return 创建的UIColor对象
 */
UIColor *wbt_UIColorMakeRGBA(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);


@interface UIColor (WBTHelper)

+ (UIColor *)wbt_colorWithHexValue:(NSInteger)hex alpha:(CGFloat)alpha;

+ (CGFloat)wbt_redColorFromHexRGBColor:(NSInteger)hex;
+ (CGFloat)wbt_greenColorFromRGBColor:(NSInteger)hex;
+ (CGFloat)wbt_blueColorFromRGBColor:(NSInteger)hex;

- (void)wbt_getColorComponentsWithRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

@end
