//
//  StringUtil.h
//  Candy2
//
//  Created by Aiwa on 12/3/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface StringUtil : NSObject


+ (NSString *) md5:(NSString *) input;


+(BOOL) isMobileNumber: (NSString*) mobileNumber;

+(NSString*) numberConvert:(NSString*) numStr;

+(CGFloat) getTextWidthForSingle: (NSString*) text forFont:(UIFont*) font;

+(CGFloat) getTextHeight: (NSString*) text forFont:(UIFont*) font andWidth:(CGFloat) width;

+(NSMutableAttributedString*) getAttrText:(NSString*) txt MultiText:(NSAttributedString*) multiText WithAttr:(NSArray*) arr;

+(BOOL) nullArr:(NSArray *) arr;

+(BOOL) nullStr:(NSString*) str;

+(NSString*) encodeUrl:(NSString*) url;

+(NSString*) sharedString:(NSString*) url Content:(NSString*) content;

+(NSString*) dateString:(NSDate*) date;

+(NSString*) calendarDate:(NSDate*) pDate;

+(NSArray*) sortArray:(NSArray*) arr;

+(NSString*) dictToJsonString:(NSDictionary*) dict;

+(NSDictionary*) jsonStringToDict:(NSString*) str;

+(NSString*) base64Encode:(NSString*) str;

+(NSString*) base64Decode:(NSString*) str;




+ (UIImage *) dataURL2Image: (NSString *) imgSrc;

+ (NSString *) image2DataURL: (UIImage *) image;

+(NSString*) imageNameSplit:(NSString*) pathStr;

+(BOOL) containsString:(NSString*) sourceStr checkedStr:(NSString*) checkedString;


@end
