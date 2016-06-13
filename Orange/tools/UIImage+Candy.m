//
//  UIImage+Candy.m
//  Candy
//
//  Created by Aiwa on 8/21/15.
//  Copyright (c) 2015 Sina. All rights reserved.
//

#import "UIImage+Candy.h"

@implementation UIImage (Candy)

+(UIImage*) imageFromColor: (UIColor*) color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *retImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return retImg;
}

@end
