//
//  SimageEngine.h
//  Orange
//
//  Created by Aiwa on 4/25/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SbasicEngine.h"
#import "SpictureModel.h"

@interface SimageEngine : SbasicEngine


/// 获取图片链接接口
-(void) getPictureUrl:(NSString* __nonnull) picture_id
                 Kind:(NSString* __nonnull) kind
              EventId:(NSString* __nonnull) event_id
               NewsId:(NSString* __nonnull) news_id
//                  PageSize:(NSString* __nonnull) pagesize
//                  PageNum:(NSString* __nonnull) pagenum
              Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

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
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.17 更新图片链接接口
-(void) updatePictureInfo:(NSString* __nonnull) picture_id
                   NewsId:(NSString* __nonnull) news_id
               PictureUrl:(NSString* __nonnull) pic_url
                  EventId:(NSString* __nonnull) event_id
                     Kind:(NSString* __nonnull) kind
                  Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
          completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.17 更新图片链接接口
-(void) deletePictureById:(NSString* __nonnull) picture_id
                  Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
          completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;


-(void) uploadImage:(UIImage*) image
        ExtraParams:(NSDictionary*) extraParams
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;



@end
