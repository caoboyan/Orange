//
//  SfileManager.m
//  Candy2
//
//  Created by Aiwa on 12/3/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "SfileManager.h"
#import "StringUtil.h"

#import "AFNetworking.h"

@implementation SfileManager

+(void) downloadFile:(NSString*) url Block:(void(^)(BOOL success, NSError *error )) block
{
    NSString *md5 = [StringUtil md5:url];
    NSString* fileName = [NSString stringWithFormat:@"%@.mp3",md5];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: fileName];
    if ([fileManager fileExistsAtPath:path]) {
        block(YES, nil);
    }else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully downloaded file to %@", path);
            block(YES, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            block(NO,error);
        }];
        [operation start];
    }
}

+(void) convertFile:(NSString*) fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileNameAndExt = [NSString stringWithFormat:@"%@.mp3",fileName];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: fileNameAndExt];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSInteger lengthTemp = [data length];
    char *bytesTemp = malloc(lengthTemp);
    [data getBytes:bytesTemp length:lengthTemp];
    for (int i=0; i<lengthTemp; i++) {
        bytesTemp[i] = ~bytesTemp[i];
    }
    NSData *data2 = [NSData dataWithBytes:bytesTemp length:lengthTemp];
    NSString *tmpPath = NSTemporaryDirectory();
    NSString *tmpFilePath = [tmpPath stringByAppendingPathComponent:fileNameAndExt];
    [data2 writeToFile:tmpFilePath atomically:YES];
    free(bytesTemp); /////
}

+(void) clearTempDirectoryMp3File
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tmpPath = NSTemporaryDirectory();
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:tmpPath error:&error];
    if (error == nil) {
        for (NSString* file in fileList) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"*.mp3$" options:NSRegularExpressionCaseInsensitive error:nil];
            NSTextCheckingResult *match = [regex firstMatchInString:file options:0 range:NSMakeRange(0, [file length])];
            if (match != nil) {
                NSString *filePath = [tmpPath stringByAppendingPathComponent:file];
                NSError *err;
                [fileManager removeItemAtPath:filePath error:&err];
            }
        }
    }
}

+(void) clearDocMp3File
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSError *error;
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (error == nil) {
        for (NSString* file in fileList) {
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"*.mp3$" options:NSRegularExpressionCaseInsensitive error:nil];
            NSTextCheckingResult *match = [regex firstMatchInString:file options:0 range:NSMakeRange(0, [file length])];
            if (match != nil) {
                NSString *filePath = [documentsDirectory stringByAppendingPathComponent:file];
                NSError *err;
                [fileManager removeItemAtPath:filePath error:&err];
            }
        }
    }
}







@end
