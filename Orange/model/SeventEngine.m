//
//  SeventEngine.m
//  Orange
//
//  Created by Aiwa on 4/1/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SeventEngine.h"
#import "SeventModel.h"

@implementation SeventEngine

/// 获取用户发布的活动列表
-(void) userEventsList:(NSInteger) pagesize PageNum:(NSInteger) pagenum Uid:(NSString*) owneruid
           Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
   completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [dict setObject:[NSNumber numberWithInteger:pagenum] forKey:@"pagenum"];
    [dict setObject:[NSNumber numberWithInteger:[owneruid integerValue]] forKey:@"owneruid"];
    NSDictionary* finalDic = @{@"func_name" : @"GetUserEventsViewList",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// 添加新事件
-(void) addNewEvent:(NSString*) etype
             Stopic:(NSString*) Topic
            Scontent:(NSString*) Content
            Smax_num:(NSInteger) Max_num
            Scosts:(NSString*) COSTS
            Saddress:(NSString*) ADDRESS
            Sstartdate:(NSString*) STARTDATE
            Sstopdate:(NSString*) STOPDATE
            Slongitude:(NSString*) longitude
            Slatitude:(NSString*) latitude
            Sowner_uid:(NSInteger) owner_uid
            SCurrent_num:(NSInteger) Current_num
            Sstate:(NSInteger) state
            Sdate:(NSString*) date
            Encrypt:(NSString*) encrypt
            Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:[NSNumber numberWithInteger:Max_num] forKey:@"Max_num"];
    [dict setObject:[NSNumber numberWithInteger:owner_uid] forKey:@"owner_uid"];
    [dict setObject:[NSNumber numberWithInteger:Current_num] forKey:@"Current_num"];
    [dict setObject:[NSNumber numberWithInteger:state] forKey:@"state"];
    [dict setObject:etype forKey:@"etype"];
    [dict setObject:Topic forKey:@"Topic"];
    [dict setObject:Content forKey:@"Content"];
    [dict setObject:COSTS forKey:@"COSTS"];
    [dict setObject:ADDRESS forKey:@"ADDRESS"];
    [dict setObject:STARTDATE forKey:@"STARTDATE"];
    [dict setObject:STOPDATE forKey:@"STOPDATE"];
    [dict setObject:longitude forKey:@"longitude"];
    [dict setObject:latitude forKey:@"latitude"];
    [dict setObject:date forKey:@"date"];
    
    NSDictionary* finalDic = @{@"func_name" : @"AddNewEvent",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// 更新事件信息
-(void) updateEvent:(NSString*) etype
             Stopic:(NSString*) Topic
           Scontent:(NSString*) Content
           Smax_num:(NSInteger) Max_num
             Scosts:(NSString*) COSTS
           Saddress:(NSString*) ADDRESS
         Sstartdate:(NSString*) STARTDATE
          Sstopdate:(NSString*) STOPDATE
         Slongitude:(NSString*) longitude
          Slatitude:(NSString*) latitude
         Sowner_uid:(NSInteger) owner_uid
       SCurrent_num:(NSInteger) Current_num
             Sstate:(NSInteger) state
              Sdate:(NSString*) date
            Encrypt:(NSString*) encrypt
              Extra:(NSDictionary*) extra
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:[NSNumber numberWithInteger:Max_num] forKey:@"Max_num"];
    [dict setObject:[NSNumber numberWithInteger:owner_uid] forKey:@"owner_uid"];
    [dict setObject:[NSNumber numberWithInteger:Current_num] forKey:@"Current_num"];
    [dict setObject:[NSNumber numberWithInteger:state] forKey:@"state"];
    [dict setObject:etype forKey:@"etype"];
    [dict setObject:Topic forKey:@"Topic"];
    [dict setObject:Content forKey:@"Content"];
    [dict setObject:COSTS forKey:@"COSTS"];
    [dict setObject:ADDRESS forKey:@"ADDRESS"];
    [dict setObject:STARTDATE forKey:@"STARTDATE"];
    [dict setObject:STOPDATE forKey:@"STOPDATE"];
    [dict setObject:longitude forKey:@"longitude"];
    [dict setObject:latitude forKey:@"latitude"];
    [dict setObject:date forKey:@"date"];
    
    NSDictionary* finalDic = @{@"func_name" : @"UpdateEventInfo",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    handler(arrData, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// 删除事件
-(void) deleteEventByEid:(NSString*) eid
            Encrypt:(NSString*) encrypt
              Extra:(NSDictionary*) extra
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:eid forKey:@"eid"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteEventByEid",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    handler(arrData, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// 按时间倒序查看所有事件
-(void) getEventsList:(NSString*) pagesize
             PageNum:(NSString*) pagenum
            Encrypt:(NSString*) encrypt
              Extra:(NSDictionary*) extra
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }

    [dict setObject:pagesize forKey:@"pagesize"];
    [dict setObject:pagenum forKey:@"pagenum"];
    
    NSDictionary* finalDic = @{@"func_name" : @"GetEventsList",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// 获取推荐给用户的活动数据
-(void) userRecommendEventList:(NSString*) state
                      Pagesize: (NSInteger) pagesize
                       PageNum:(NSInteger) pagenum
                           Uid:(NSString*) uid
                           Lat:(NSString*) lat
                           Lon:(NSString*) lon
               Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:state forKey:@"state"];
    [dict setObject:[NSString stringWithFormat:@"%ld",pagesize] forKey:@"pagesize"];
    [dict setObject:[NSString stringWithFormat:@"%ld",pagenum] forKey:@"pagenum"];
    [dict setObject:uid forKey:@"uid"];
    [dict setObject:lat forKey:@"lat"];
    [dict setObject:lon forKey:@"lng"];
    NSDictionary* finalDic = @{@"func_name" : @"GetUserRecommoned",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// 获取用户附近的活动数据
-(void) userNearbyEventList:(NSString*) state
                      Pagesize: (NSInteger) pagesize
                       PageNum:(NSInteger) pagenum
                           Lat:(NSString*) lat
                           Lon:(NSString*) lon
                       Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
               completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:state forKey:@"state"];
    [dict setObject:[NSString stringWithFormat:@"%ld",pagesize] forKey:@"pagesize"];
    [dict setObject:[NSString stringWithFormat:@"%ld",pagenum] forKey:@"pagenum"];
    [dict setObject:lat forKey:@"lat"];
    [dict setObject:lon forKey:@"lng"];
    NSDictionary* finalDic = @{@"func_name" : @"GetNearbyEvent",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// 按时间倒序查看所有事件
-(void) allEventsList:(NSInteger) pagesize
                    PageNum:(NSInteger) pagenum
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [dict setObject:[NSNumber numberWithInteger:pagenum] forKey:@"pagenum"];
    NSDictionary* finalDic = @{@"func_name" : @"GetEventsList",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

//1.19增加事件参与用户
-(void) eventAddMember:(NSString*) eid
              UserUid:(NSString*) UID
              Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:@"1" forKey:@"id"];
    [dict setObject:eid forKey:@"eid"];
    [dict setObject:UID forKey:@"UID"];
    
    NSDictionary* finalDic = @{@"func_name" : @"AddNewMember",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    handler(arrData, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}
//1.20删除事件参与用户
-(void) eventDeleteMember:(NSString*) eid
               UserUid:(NSString*) UID
               Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:eid forKey:@"eid"];
    [dict setObject:UID forKey:@"UID"];
    
    NSDictionary* finalDic = @{@"func_name" : @"DeleteMember",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    handler(arrData, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}
//1.21增加好友
-(void) addFriend:(NSString*) my_id
         FriendId:(NSString*) friend_id
            State:(NSString*) state
          Encrypt:(NSString*) encrypt
            Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:my_id forKey:@"my_id"];
    [dict setObject:friend_id forKey:@"friend_id"];
    [dict setObject:@"1" forKey:@"state"];
    
    NSDictionary* finalDic = @{@"func_name" : @"AddFriend",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    handler(arrData, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}
//1.24 获取用户发起活动列表
-(void) userEventList:(NSString*) state
                  Uid:(NSString*) uid
             PageSize:(NSInteger) pagesize
              PageNum:(NSInteger) pagenum
              Encrypt:(NSString*) encrypt
                Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:@"1" forKey:state];
    [dict setObject:uid forKey:uid];
    [dict setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [dict setObject:[NSNumber numberWithInteger:pagenum] forKey:@"pagenum"];
    NSDictionary* finalDic = @{@"func_name" : @"GetUserEventList",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

//1.25 获取用户参与活动列表
-(void) userJoinedEventList:(NSString*) state
              Uid:(NSString*) uid
              PageSize:(NSInteger) pagesize
              PageNum:(NSInteger) pagenum
              Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:@"0" forKey:state];
    [dict setObject:uid forKey:uid];
    [dict setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [dict setObject:[NSNumber numberWithInteger:pagenum] forKey:@"pagenum"];
    NSDictionary* finalDic = @{@"func_name" : @"GetUserJoinEventList",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SeventModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}
//1.26 获取事件图片列表

-(void) eventPictureList:(NSString*) eid
                    PageSize:(NSInteger) pagesize
                    PageNum:(NSInteger) pagenum
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:eid forKey:eid];
    [dict setObject:[NSNumber numberWithInteger:pagesize] forKey:@"pagesize"];
    [dict setObject:[NSNumber numberWithInteger:pagenum] forKey:@"pagenum"];
    NSDictionary* finalDic = @{@"func_name" : @"GetEventPicList",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    handler(arrData, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

///1.27 获取用户喜好列表

- (void)getUserLikeList:(NSString *)uid Encrypt:(NSString *)encrypt Extra:(NSDictionary *)extra completeHandler:(void (^)(id, BOOL, NSError *))handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject :uid forKey:@"uid"];
    NSDictionary* finalDic = @{@"func_name" : @"GetUserLikeEventType",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

///1.28 增加用户喜好列表
- (void)addUserEvent:(NSString *)uid
             Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
     completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject :uid forKey:@"uid"];
    NSDictionary* finalDic = @{@"func_name" : @"AddUserLikeEventType",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];

}


///1.29 删除用户喜好列表
- (void)deleteUserLike:(NSString *)uid
               Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject :uid forKey:@"uid"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteUserLikeEventType",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

///1.30 获取用户收藏事件列表
- (void)getUserTreasureList:(NSInteger)uid
                   PageSize:(NSInteger) pagesize
                    PageNum:(NSInteger) pagenum
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:@(uid) forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%zd",pagesize] forKey:@"pagesize"];
    [dict setObject:[NSString stringWithFormat:@"%zd",pagenum] forKey:@"pagenum"];
    [dict setObject:@"1" forKey:@"attr"];
    NSDictionary* finalDic = @{@"func_name" : @"GetUserlikeEvent",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.31 增加用户喜好事件
- (void)addUserLikeEvent:(NSInteger)uid
                     eid:(NSInteger)eid
                    attr:(NSInteger)attr
                 Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:@(uid) forKey:@"uid"];
    [dict setObject:@(attr) forKey:@"attr"];
    [dict setObject:@(eid) forKey:@"eid"];
    NSDictionary* finalDic = @{@"func_name" : @"AddUserlikeEvent",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.32 删除用户喜好事件
- (void)deleteUserLikeEvent:(NSInteger)uid
                        eid:(NSInteger)eid
                       attr:(NSInteger)attr
                    Encrypt:(NSString *)encrypt
                      Extra:(NSDictionary *)extra completeHandler:(void (^)(id, BOOL, NSError *))handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    [dict setObject:@(uid) forKey:@"uid"];
    [dict setObject:@(attr) forKey:@"attr"];
    [dict setObject:@(eid) forKey:@"eid"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteUserLikeEvent",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.33 获取事件评论

- (void)getEventComment:(NSInteger)eid
               PageSize:(NSInteger)pagesize
                PageNum:(NSInteger)pagenum
                Encrypt:(NSString *)encrypt
                  Extra:(NSDictionary *)extra completeHandler:(void (^)(id, BOOL, NSError *))handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(1) forKey:@"eid"];
    [dict setObject:[NSString stringWithFormat:@"%zd",pagesize] forKey:@"pagesize"];
    [dict setObject:[NSString stringWithFormat:@"%zd",pagenum] forKey:@"pagenum"];
    NSDictionary* finalDic = @{@"func_name" : @"GetEventComment",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        NSArray *arrData = (NSArray*) data;
        if (error == nil) {
            handler(arrData, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
    
    
}

///1.34 增加评论
- (void)addEventComment:(NSInteger)commentid News_id:(NSInteger)News_id content:(NSString *)content commenter_id:(NSInteger)commenter_id Encrypt:(NSString *)encrypt Extra:(NSDictionary *)extra completeHandler:(void (^)(id, BOOL, NSError *))handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(commentid) forKey:@"comment_id"];
    [dict setObject:@(News_id) forKey:@"News_id"];
    [dict setObject:content forKey:@"content"];
    [dict setObject:@(commenter_id) forKey:@"commenter_id"];
    NSDictionary* finalDic = @{@"func_name" : @"AddEventComment",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.35 删除评论
- (void)deleteEventComment:(NSInteger)comment_id Encrypt:(NSString *)encrypt Extra:(NSDictionary *)extra completeHandler:(void (^)(id, BOOL, NSError *))handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(comment_id) forKey:@"comment_id"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteEventComment",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}


//1.36 获取GO WITH ORANGER事件列表

- (void)getGoWithOranger:(NSInteger) pagesize
                 PageNum:(NSInteger) pagenum
                   State:(NSInteger) state
                 Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{

    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(state) forKey:@"state"];
    NSDictionary* finalDic = @{@"func_name" : @"GetGoWithOranger",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];

}

//1.37 增加GO WITH ORANGER事件列表

- (void)addGoWithOranger:(NSInteger)EID
                   ETYPE:(NSString *)ETYPE
                   TOPIC:(NSString *)TOPIC
                 CONTENT:(NSString *)CONTENT
                 MAX_NUM:(NSInteger)MAX_NUM
                   COSTS:(NSString *)COSTS
                 ADDRESS:(NSString *)ADDRESS
               STARTDATE:(NSString *)STARTDATE
                STOPDATE:(NSString *)STOPDATE
               LONGITUDE:(NSString *)LONGITUDE
                LATITUDE:(NSString *)LATITUDE
                   STATE:(NSInteger)STATE
                 MIN_NUM:(NSInteger)MIN_NUM
                    TIME:(NSString *)TIME
                 Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(EID) forKey:@"EID"];
    [dict setObject:ETYPE forKey:@"ETYPE"];
    [dict setObject:TOPIC forKey:@"TOPIC"];
    [dict setObject:CONTENT forKey:@"CONTENT"];
    [dict setObject:@(MAX_NUM) forKey:@"MAX_NUM"];
    [dict setObject:COSTS forKey:@"COSTS"];
    [dict setObject:ADDRESS forKey:@"ADDRESS"];
    [dict setObject:STARTDATE forKey:@"STARTDATE"];
    [dict setObject:STOPDATE forKey:@"STOPDATE"];
    [dict setObject:LONGITUDE forKey:@"LONGITUDE"];
    [dict setObject:LATITUDE forKey:@"LATITUDE"];
    [dict setObject:@(STATE) forKey:@"STATE"];
    [dict setObject:@(MIN_NUM) forKey:@"MIN_NUM"];
    [dict setObject:TIME forKey:@"TIME"];
    NSDictionary* finalDic = @{@"func_name" : @"AddGoWithOranger",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.38 删除GO WITH ORANGER事件列表
- (void)deleteGoWithOranger:(NSInteger)eid
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(eid) forKey:@"eid"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteGoWithOranger",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.39 获取oranger活动人员
- (void)getOrangeMember:(NSInteger)eid
          schedule_date:(NSString *)schedule_date
               pagesize:(NSInteger)pagesize
                pagenum:(NSInteger)pagenum
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(eid) forKey:@"eid"];
    [dict setObject:schedule_date forKey:@"schedule_date"];
    [dict setObject:@(pagesize) forKey:@"pagesize"];
    [dict setObject:@(pagenum) forKey:@"pagenum"];
    NSDictionary* finalDic = @{@"func_name" : @"GetOrangerMember",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.40 添加oranger活动人员AddOrangerMember
- (void)addOrangeMember:(NSInteger)oid
                    EID:(NSInteger)EID
                    UID:(NSInteger)UID
          SCHEDULE_DATE:(NSString *)SCHEDULE_DATE
             APPLY_DATE:(NSString *)APPLY_DATE
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(oid) forKey:@"id"];
    [dict setObject:@(EID) forKey:@"EID"];
    [dict setObject:@(UID) forKey:@"UID"];
    [dict setObject:SCHEDULE_DATE forKey:@"SCHEDULE_DATE"];
    [dict setObject:APPLY_DATE forKey:@"APPLY_DATE"];
    NSDictionary* finalDic = @{@"func_name" : @"GetOrangerMember",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.41 删除OrangerMember
- (void)deleteOrangeMember:(NSInteger)oid
                   Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(oid) forKey:@"id"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteOrangerMember",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.42 获取用户参与的GO WITH ORANGER事件列表
- (void)getGoWithOrangerByUID:(NSInteger)uid
                        state:(NSInteger)state
                     pagesize:(NSString *)pagesize
                      pagenum:(NSString *)pagenum
                      Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
              completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@(uid) forKey:@"uid"];
    [dict setObject:@(state) forKey:@"state"];
    [dict setObject:pagesize forKey:@"pagesize"];
    [dict setObject:pagenum forKey:@"pagenum"];
    
    NSDictionary* finalDic = @{@"func_name" : @"GetGoWithOrangerbyUID",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.43 创建群聊
- (void)createChatGroup:(NSString *)groupname
          descscription:(NSString *)descscription
                  owner:(NSString *)owner
               maxusers:(NSInteger)maxusers
                members:(NSString *)members
            grouppublic:(NSString *)grouppublic
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupname forKey:@"groupname"];
    [dict setObject:descscription forKey:@"descscription"];
    [dict setObject:owner forKey:@"owner"];
    [dict setObject:@(maxusers) forKey:@"maxusers"];
    [dict setObject:members forKey:@"members"];
    [dict setObject:grouppublic forKey:@"grouppublic"];
    
    NSDictionary* finalDic = @{@"func_name" : @"CreateChatGroup",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.44更新群聊图片
- (void)updateChatgroupPicUrl:(NSString *)groupid
                  grouppicurl:(NSString *)grouppicurl
                      Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
              completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupid forKey:@"groupid"];
    [dict setObject:grouppicurl forKey:@"grouppicurl"];
    NSDictionary* finalDic = @{@"func_name" : @"UpdateChatgroupPicUrl",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.45获取群成员
- (void)getChatGroupMembers:(NSString *)groupid
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupid forKey:@"groupid"];
    NSDictionary* finalDic = @{@"func_name" : @"GetChatGroupMembers",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}


//1.46 添加单个群成员
- (void)addChatGroupMember:(NSString *)groupid
                  username:(NSString *)username
                   Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupid forKey:@"groupid"];
    [dict setObject:username forKey:@"username"];
    NSDictionary* finalDic = @{@"func_name" : @"AddChatGroupMember",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.47 添加多个群成员
- (void)addChatGroupMembers:(NSString *)groupid
                      users:(NSString *)users
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupid forKey:@"groupid"];
    [dict setObject:users forKey:@"users"];
    NSDictionary* finalDic = @{@"func_name" : @"AddChatGroupMembers",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}
//1.48 删除群成员
- (void)deleteChatGroupMember:(NSString *)groupid
                     username:(NSString *)username
                      Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
              completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupid forKey:@"groupid"];
    [dict setObject:username forKey:@"username"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteChatGroupMember",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.50 转让群组
- (void)ChangeChatGroupOwner:(NSString *)groupid
                    username:(NSString *)username
                     Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
             completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupid forKey:@"groupid"];
    [dict setObject:username forKey:@"username"];
    NSDictionary* finalDic = @{@"func_name" : @"ChangeChatGroupOwner",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}
//1.51 删除群组
- (void)deleteChatGroup:(NSString *)groupid
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler{
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:groupid forKey:@"groupid"];
    NSDictionary* finalDic = @{@"func_name" : @"DeleteChatGroup",
                               @"encrypt" : encrypt,
                               @"func_param" : dict};
    [self postNetworkRequst:nil parameters:finalDic completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
        if (error == nil) {
            handler(data, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

@end
