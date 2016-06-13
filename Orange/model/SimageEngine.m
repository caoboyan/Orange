//
//  SimageEngine.m
//  Orange
//
//  Created by Aiwa on 4/25/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SimageEngine.h"

@implementation SimageEngine


/// 获取图片链接接口
-(void) getPictureUrl:(NSString* __nonnull) picture_id
              Kind:(NSString* __nonnull) kind
                  EventId:(NSString* __nonnull) event_id
                  NewsId:(NSString* __nonnull) news_id
//                  PageSize:(NSString* __nonnull) pagesize
//                  PageNum:(NSString* __nonnull) pagenum
               Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:picture_id forKey:@"picture_id"];
    [dict setObject:kind forKey:@"kind"];
    [dict setObject:event_id forKey:@"event_id"];
    [dict setObject:news_id forKey:@"news_id"];
    [dict setObject:@"10" forKey:@"pagesize"];
    [dict setObject:@"0" forKey:@"pagenum"];
    
    NSDictionary* finalDic = @{@"func_name" : @"GetPictureUrl",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SpictureModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

///1.16添加图片链接接口
/**  增加图片   当增加事件图片时候 news_id 取值为0  event_id为事件id
 
 当增加广告时候 event_id取0  news_id为广告id
 
 kind取值区分图片位置 事件首页图片为1
 其他页面可自定义为0 检索时注意定义值即可
 **/
-(void) addPictureUrl:(NSString* __nonnull) picture_id
               NewsId:(NSString* __nonnull) news_id
               PictureUrl:(NSString* __nonnull) pic_url
              EventId:(NSString* __nonnull) event_id
                 Kind:(NSString* __nonnull) kind
              Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:picture_id forKey:@"picture_id"];
    [dict setObject:news_id forKey:@"news_id"];
    [dict setObject:pic_url forKey:@"pic_url"];
    [dict setObject:event_id forKey:@"event_id"];
    [dict setObject:kind forKey:@"kind"];
    NSDictionary* finalDic = @{@"func_name" : @"AddPictureUrl",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    handler(nil, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

///1.17 更新图片链接接口
-(void) updatePictureInfo:(NSString* __nonnull) picture_id
               NewsId:(NSString* __nonnull) news_id
           PictureUrl:(NSString* __nonnull) pic_url
              EventId:(NSString* __nonnull) event_id
                 Kind:(NSString* __nonnull) kind
              Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:picture_id forKey:@"picture_id"];
    [dict setObject:news_id forKey:@"news_id"];
    [dict setObject:pic_url forKey:@"pic_url"];
    [dict setObject:event_id forKey:@"event_id"];
    [dict setObject:kind forKey:@"kind"];
    NSDictionary* finalDic = @{@"func_name" : @"UpdatePictureInfo",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    handler(nil, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

///1.17 更新图片链接接口
-(void) deletePictureById:(NSString* __nonnull) picture_id
                  Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
          completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:picture_id forKey:@"picture_id"];
    NSDictionary* finalDic = @{@"func_name" : @"DeletePictureByPid",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    handler(nil, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

-(void) uploadImage:(UIImage*) image
        ExtraParams:(NSDictionary*) extraParams
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extraParams == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extraParams];
    }
    
    NSString* imageUploader =  @"http://123.127.244.149:8090/api/upload/files";
    [self postImageRequst:imageUploader parameters:dict Images:@{@"WebApiDoc01.png":image} completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}




@end
