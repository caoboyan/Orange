//
//  SbasicEngine.m
//  Candy2
//
//  Created by Aiwa on 10/31/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "SbasicEngine.h"

@interface SbasicEngine ()

@property (nonatomic, retain) AFHTTPRequestOperationManager*  networkRequest;

@end

@implementation SbasicEngine

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkRequest = [[AFHTTPRequestOperationManager alloc] init];
        NSMutableSet *set = [NSMutableSet setWithSet:self.networkRequest.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        self.networkRequest.responseSerializer.acceptableContentTypes = [NSSet setWithSet:set];
    }
    return self;
}
-(void) getNetworkRequst:(NSString*) url parameters:(NSDictionary*) param completeHandler:(void(^)(AFHTTPRequestOperation* operation, id data, NSError* error)) handler{
    NSString *surl = url;
    NSMutableDictionary *dict;
    if (param == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [NSMutableDictionary dictionaryWithDictionary:param];
    }
    if (K_DEBUG_FLAG) {
        NSLog(@"==REQUEST==START==== %@ ===== param: %@ ",surl, dict);
    }
    NSMutableDictionary* md = [NSMutableDictionary dictionaryWithDictionary:dict];
    NSString* encrypt = [md objectForKey:@"encrypt"];
    NSString* paramStr = [StringUtil dictToJsonString:[md objectForKey:@"func_param"]];
    if ([encrypt isEqualToString:@"y"]) {
        [md setObject:[StringUtil base64Encode:paramStr] forKey:@"func_param"];
    }else {
        [md setObject:paramStr forKey:@"func_param"];
    }
    
    NSString* uid = [[SaccountStore sharedInstance] getCurrentUid];
    if ([StringUtil nullStr:uid]) {
        [md setObject:@"M0AxMjIyMjIyMjIyMjIyMjIyMjIyMjIyMg==" forKey:@"access_token"];
    }else {
        double date = [NSDate date].timeIntervalSince1970InMilliSecond;
        NSNumber* date2 = [NSNumber numberWithDouble:date];
        NSString* dateStr = [date2 stringValue];
        NSString* token = [StringUtil base64Encode:[NSString stringWithFormat:@"%@@%@",uid, dateStr]];
        [md setObject:token forKey:@"access_token"];
    }

    [self.networkRequest GET:md parameters:dict success:^(AFHTTPRequestOperation*  operation, id responseObject) {
        NSDictionary *dict;
        @try {
            dict = (NSDictionary*) responseObject;
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        if (dict == nil) {
            NSError *err = [[NSError alloc] initWithDomain:@"未返回任何数据！" code:9999 userInfo:nil];
            if (K_DEBUG_FLAG) {
                NSLog(@"==REQUEST==ERROR==== %@ message:===== %@",surl,err.domain);
            }
            handler(operation, nil, err);
        }else {
            id data = [dict objectForKey:@"data"];
            NSDictionary *status = [dict objectForKey:@"status"];
            NSInteger statusCode = [[status objectForKey:@"code"] integerValue];
            NSString *statusMsg = [status objectForKey:@"msg"];
            if (statusCode == 200) { //success
                if (K_DEBUG_FLAG) {
                    NSLog(@"==REQUEST==SUCCESS==== %@ success, message:===== %@",url,statusMsg);
                }
                handler(operation, dict, nil);
            }else {
                if (statusCode == 100) {
                    NSError *error = [NSError errorWithDomain:statusMsg code:statusCode userInfo:nil];
                    handler(operation, nil, error);
                }
            }
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        if (K_DEBUG_FLAG) {
            NSLog(@"==REQUEST== %@ error : %@",surl, error);
        }
        if ([error.domain isEqualToString:@"NSURLErrorDomain"]) {
            NSError *serr = [NSError errorWithDomain:@"网络断开啦，尝试再链接一下！" code:error.code userInfo:nil];
            handler(operation, nil, serr);
        }else {
            handler(operation, nil, error);
        }
    }];
}

-(void) postNetworkRequst:(NSString*) url parameters:(NSDictionary*) param completeHandler:(void(^)(AFHTTPRequestOperation* operation, id data, NSError* error)) handler
{
    if ([StringUtil nullStr:url]) {
        url = BASE_URL;
    }
    
    NSMutableDictionary *dicts;
    if (param == nil) {
        dicts = [[NSMutableDictionary alloc] init];
    }else {
        dicts = [NSMutableDictionary dictionaryWithDictionary:param];
    }
   
    
    NSMutableDictionary* md = [NSMutableDictionary dictionaryWithDictionary:dicts];
    NSString* encrypt = [md objectForKey:@"encrypt"];
    if ([encrypt isEqualToString:@"y"]) {
        NSString* paramStr = [StringUtil dictToJsonString:[md objectForKey:@"func_param"]];
        [md setObject:[StringUtil base64Encode:paramStr] forKey:@"func_param"];
    }else {
//        [md setObject:paramStr forKey:@"func_param"];
    }
    NSString* uid = [[SaccountStore sharedInstance] getCurrentUid];
    if ([StringUtil nullStr:uid]) {
        [md setObject:@"" forKey:@"access_token"];
    }else {
        double date = [NSDate date].timeIntervalSince1970InMilliSecond;
        NSNumber* date2 = [NSNumber numberWithDouble:date];
        NSString* dateStr = [date2 stringValue];
        NSString* token = [StringUtil base64Encode:[NSString stringWithFormat:@"%@@%@",uid, dateStr]];
        [md setObject:token forKey:@"access_token"];
    }

    if (K_DEBUG_FLAG) {
        NSLog(@"==REQUEST==START==== %@ ===== param: %@ ",url, md);
    }
    
    [self.networkRequest POST:url parameters:md success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSDictionary *dict;
        @try {
            dict = (NSDictionary*) responseObject;
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        NSString *status = [dict objectForKey:@"status"];
        NSString *encrypt = [dict objectForKey:@"encrypt"];
        NSString *message = [dict objectForKey:@"message"];
        if ([status isEqualToString:@"success"]) { //success
            if (K_DEBUG_FLAG) {
                NSLog(@"==REQUEST==SUCCESS==== %@ success, message:===== %@",url,message);
            }
            if ([@"n" isEqualToString:encrypt]) {
                NSArray *arr = [dict objectForKey:@"data"];
                handler(operation, arr, nil);
            }else {
                NSString* jsonStr = [StringUtil base64Decode:[dict objectForKey:@"data"]];
                NSArray* arr = (NSArray*)[StringUtil jsonStringToDict:jsonStr];
                handler(operation, arr, nil);
            }
        }else {
            NSError *error = [NSError errorWithDomain:message code:999 userInfo:nil];
            handler(operation, nil, error);
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        if (K_DEBUG_FLAG) {
            NSLog(@"==REQUEST== %@ error : %@",url, error);
        }
        if ([error.domain isEqualToString:@"NSURLErrorDomain"]) {
            NSError *serr = [NSError errorWithDomain:@"网络断开啦，尝试再链接一下！" code:error.code userInfo:nil];
            handler(operation, nil, serr);
        }else {
            handler(operation, nil, error);
        }
    }];
}

-(void) postImageRequst:(NSString*) url parameters:(NSDictionary*) param Images:(NSDictionary*) images completeHandler: (void(^)(AFHTTPRequestOperation* operation, id data, NSError* error)) handler
{
    NSString *surl = url;
    NSMutableDictionary *dict;
    if (param == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [NSMutableDictionary dictionaryWithDictionary:param];
    }
    NSString* uid = [[SaccountStore sharedInstance] getCurrentUid];
    if ([StringUtil nullStr:uid]) {
        [dict setObject:@"" forKey:@"access_token"];
    }else {
        double date = [NSDate date].timeIntervalSince1970InMilliSecond;
        NSNumber* date2 = [NSNumber numberWithDouble:date];
        NSString* dateStr = [date2 stringValue];
        NSString* token = [StringUtil base64Encode:[NSString stringWithFormat:@"%@@%@",uid, dateStr]];
        [dict setObject:token forKey:@"access_token"];
    }

    self.networkRequest.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    self.networkRequest.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    [self.networkRequest.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.networkRequest.requestSerializer setValue:@"charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [self.networkRequest POST:surl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        if (images != nil) {
            NSArray *keys = [images allKeys];
            for (NSString* key in keys) {
                UIImage *image = [images objectForKey:key];
                NSData *data = UIImageJPEGRepresentation(image, 0.5);
                [formData appendPartWithFileData:data name:key fileName:@"file.png" mimeType:@"image/jpeg"];
            }
        }
        
    } success:^(AFHTTPRequestOperation* operation, id responseObject) {
        NSDictionary *dict;
        @try {
            dict = (NSDictionary*) responseObject;
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        if (dict == nil) {
            NSError *err = [[NSError alloc] initWithDomain:@"未返回任何数据！" code:9999 userInfo:nil];
            if (K_DEBUG_FLAG) {
                NSLog(@"==REQUEST==ERROR==== %@ message:===== %@",surl,err.domain);
            }
            handler(operation, nil, err);
        }else {
            handler(operation, dict, nil);
            
            /**
            id data = [dict objectForKey:@"data"];
            NSDictionary *status = [dict objectForKey:@"status"];
            NSInteger statusCode = [[status objectForKey:@"code"] integerValue];
            NSString *statusMsg = [status objectForKey:@"msg"];
            if (statusCode == 200) { //success
                if (K_DEBUG_FLAG) {
                    NSLog(@"==REQUEST==SUCCESS==== %@ success, message:===== %@",surl,statusMsg);
                }
                handler(operation, data, nil);
            }else {
                if (statusCode == 100) {
                    NSError *error = [NSError errorWithDomain:statusMsg code:statusCode userInfo:nil];
                    handler(operation, nil, error);
                }
            }
             **/
        }
    } failure:^(AFHTTPRequestOperation* operation, NSError* error) {
        if (K_DEBUG_FLAG) {
            NSLog(@"==REQUEST== %@ error : %@",surl, error);
        }
        if ([error.domain isEqualToString:@"NSURLErrorDomain"]) {
            NSError *serr = [NSError errorWithDomain:@"网络断开啦，尝试再链接一下！" code:error.code userInfo:nil];
            handler(operation, nil, serr);
        }else {
            handler(operation, nil, error);
        }
    }];
}


@end
