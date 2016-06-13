//
//  StringUtil.m
//  Candy2
//
//  Created by Aiwa on 12/3/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil


+ (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

+(BOOL) isMobileNumber: (NSString*) mobileNumber
{
    if (mobileNumber == nil || [mobileNumber length] != 11)
    {
        return NO;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"1\\d{10}" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:mobileNumber options:0 range:NSMakeRange(0, [mobileNumber length])];
    return match != nil;
}

+(NSString*) numberConvert:(NSString*) numStr
{
    NSMutableString *str = [[NSMutableString alloc] init];
    if (numStr == nil || [numStr length] < 1)
    {
        return @"";
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *arr = nil;
    arr = [regex matchesInString:numStr options:0 range:NSMakeRange(0, [numStr length])];
    //NSTextCheckingResult *match = [regex firstMatchInString:numStr options:0 range:NSMakeRange(0, [numStr length])];
    for (NSTextCheckingResult* res in arr) {
        NSString *st = [numStr substringWithRange:res.range];
        [str appendString:st];
    }
    return str;
}

+(CGFloat) getTextWidthForSingle: (NSString*) text forFont:(UIFont*) font
{
    return [text boundingRectWithSize:CGSizeMake(320, 2000) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size.width;
}

+(CGFloat) getTextHeight: (NSString*) text forFont:(UIFont*) font andWidth:(CGFloat) width
{
    //    UILabel * lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 100)];
    //    lable.text= text;
    //    lable.numberOfLines = 0 ;
    //    lable.font = font;
    //    return  [lable sizeThatFits:CGSizeMake(width, MAXFLOAT)].height + 2;
    return [text boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingTruncatesLastVisibleLine |
            NSStringDrawingUsesLineFragmentOrigin |
            NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height+5;
    //    return [text boundingRectWithSize:CGSizeMake(width-16, 2000) options:NSStringDrawingTruncatesLastVisibleLine |
    //            NSStringDrawingUsesLineFragmentOrigin |
    //            NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height+16;
    //    return [text sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
}

+(NSMutableAttributedString*) getAttrText:(NSString*) txt MultiText:(NSAttributedString*) multiText WithAttr:(NSArray*) arr
{
    NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:multiText];
    for (int i=0; i<[arr count]; i++) {
        UIColor *color = [UIColor wbt_colorWithHexValue:0x9F9F9F alpha:1];
        NSRange range = [txt rangeOfString:[arr objectAtIndex:i]];
        [mulStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return mulStr;
}

+(BOOL) nullArr:(NSArray *) arr
{
    for (NSString* str in arr) {
        if (str == nil || [@"" isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}

+(BOOL) nullStr:(NSString*) str
{
    return str == nil || [@"" isEqualToString:str];
}

+(NSString*) encodeUrl:(NSString*) url
{
    NSString* ret = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return ret;
}


+(NSString*) sharedString:(NSString*) url Content:(NSString*) content
{
    NSInteger urllen = [url length] +1 / 2;
    NSString *composedContent;
    NSInteger left = 138 - urllen -5;
    if ([content length] < left) {
        composedContent = content;
    }else{
        composedContent = [NSString stringWithFormat:@"%@....",[content substringFromIndex:left-2]];
    }
    return [NSString stringWithFormat:@"@会姐会买 %@%@",composedContent, url];
    
    return nil;
}


+(NSString*) dateString:(NSDate*) date
{
    NSDate *curDate = [NSDate date];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    int unit  = NSCalendarUnitDay;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString* prefDateStr = [formatter stringFromDate:date];
    NSString* nowDateStr = [formatter stringFromDate:curDate];
    
    NSDate *nowFixedDate = [formatter dateFromString:nowDateStr];
    NSDate *preFixedDate = [formatter dateFromString:prefDateStr];

    NSDateComponents *nowCmps = [calendar components:unit fromDate:preFixedDate toDate:nowFixedDate options:NSCalendarMatchStrictly];
    NSInteger days = nowCmps.day;
    
//    NSLog(@"days .... %ld,,,,%@,,,,,%@",days , prefDateStr, nowDateStr);
    if ([prefDateStr isEqualToString:nowDateStr]) {
        return @"今天";
    }
    if (days == 1) {
        return @"昨天";
    }else if(days == 2){
        return @"前天";
    }else {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
}


+(NSString*) calendarDate:(NSDate*) pDate
{
    NSDate *nDate = [NSDate date];
    NSDateFormatter *dfFull = [[NSDateFormatter alloc] init];
    dfFull.dateFormat = @"yyyy-MM-dd";
    NSString* nFullStr = [dfFull stringFromDate:nDate];
    NSString* pFullStr = [dfFull stringFromDate:pDate];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    timeFormatter.dateFormat = @"HH:mm";
    NSString* daytimeString =  [timeFormatter stringFromDate:pDate];

    if ([pFullStr isEqualToString:nFullStr]) { ///当天
        NSString* ret = [NSString stringWithFormat:@"今天 %@",daytimeString];
        return ret;
    }
    NSDate *fixedNowDate = [dfFull dateFromString:nFullStr];
    NSDate *fixedPreDate = [dfFull dateFromString:pFullStr];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitWeekday;
    [calendar setFirstWeekday:2];
    NSDateComponents *datec = [calendar components:NSCalendarUnitDay fromDate:fixedPreDate toDate:fixedNowDate options:0];
    
    NSDateComponents *prevWeekDec = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitWeekOfYear fromDate:fixedPreDate];
    NSDateComponents *nowWeekDec = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitWeekOfYear fromDate:fixedNowDate];
    if (datec.day == 1) { //昨天
        NSString* ret = [NSString stringWithFormat:@"昨天 %@",daytimeString];
        return ret;
    }else {
        NSString* ret = [NSString stringWithFormat:@"%@ %@",pFullStr, daytimeString];
        return ret;
    }
}

+(NSArray*) sortArray:(NSArray*) arr
{
    
    
    return [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString* str1 = (NSString*) obj1;
        NSString* str2 = (NSString*) obj2;
        NSArray* arr1 = [str1 componentsSeparatedByString:@"-"];
        NSArray* arr2 = [str2 componentsSeparatedByString:@"-"];
        for (int i = 0; i<[arr1 count]; i++) {
            if ([arr1[i] integerValue] > [arr2[i] integerValue]) {
                return (NSComparisonResult) NSOrderedAscending;
            }
            if ([arr1[i] integerValue] < [arr2[i] integerValue]) {
                return (NSComparisonResult) NSOrderedDescending;
            }
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
}

+(NSString*) dictToJsonString:(NSDictionary*) dict
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
            options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n " withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //NSString* ret =  [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    return jsonString;
}

+(NSDictionary*) jsonStringToDict:(NSString*) str
{
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
        options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+(NSString*) base64Encode:(NSString*) str
{
    NSData *nsdata = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [nsdata base64EncodedStringWithOptions:0];
}

+(NSString*) base64Decode:(NSString*) str
{
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:str options:0];
    return [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
}

+ (UIImage *) dataURL2Image: (NSString *) imgSrc
{
    NSURL *url = [NSURL URLWithString: imgSrc];
    NSData *data = [NSData dataWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData: data];
    
    return image;
}

+ (NSString *) image2DataURL: (UIImage *) image
{
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    bool isAlpha = alpha== kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast;
    
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    if (isAlpha) {
        imageData = UIImagePNGRepresentation(image);
        mimeType = @"image/png";
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
        mimeType = @"image/jpeg";
    }
    
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
    
}

+(NSString*) imageNameSplit:(NSString*) pathStr
{
    NSArray<NSString*>* arr = [pathStr componentsSeparatedByString:@"\\"];
    return  [arr lastObject];
}

+(BOOL) containsString:(NSString*) sourceStr checkedStr:(NSString*) checkedString
{
    NSRange range = [sourceStr rangeOfString:checkedString];
    return  range.location != NSNotFound;
}




@end
