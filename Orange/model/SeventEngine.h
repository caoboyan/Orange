//
//  SeventEngine.h
//  Orange
//
//  Created by Aiwa on 4/1/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SbasicEngine.h"
#import "SeventModel.h"

@interface SeventEngine : SbasicEngine

/// 获取用户发布的活动列表
-(void) userEventsList:(NSInteger) pagesize PageNum:(NSInteger) pagenum Uid:(NSString*) owneruid
               Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;


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
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

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
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

/// 删除事件
-(void) deleteEventByEid:(NSString*) eid
                 Encrypt:(NSString*) encrypt
                   Extra:(NSDictionary*) extra
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

/// 按时间倒序查看所有事件
-(void) getEventsList:(NSString*) pagesize
              PageNum:(NSString*) pagenum
              Encrypt:(NSString*) encrypt
                Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

/// 获取推荐给用户的活动数据
-(void) userRecommendEventList:(NSString*) state
                      Pagesize: (NSInteger) pagesize
                       PageNum:(NSInteger) pagenum
                           Uid:(NSString*) owneruid
                           Lat:(NSString*) lat
                           Lon:(NSString*) lon
                       Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
               completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

/// 获取用户附近的活动数据
-(void) userNearbyEventList:(NSString*) state
                   Pagesize: (NSInteger) pagesize
                    PageNum:(NSInteger) pagenum
                        Lat:(NSString*) lat
                        Lon:(NSString*) lon
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;


/// 按时间倒序查看所有事件
-(void) allEventsList:(NSInteger) pagesize
              PageNum:(NSInteger) pagenum
              Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

///1.19增加事件参与用户
-(void) eventAddMember:(NSString*) eid
               UserUid:(NSString*) UID
               Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;
///1.20删除事件参与用户
-(void) eventDeleteMember:(NSString*) eid
                  UserUid:(NSString*) UID
                  Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
          completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;
///1.21增加好友
-(void) addFriend:(NSString*) my_id
         FriendId:(NSString*) friend_id
            State:(NSString*) state
          Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
  completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.24 获取用户发起活动列表
-(void) userEventList:(NSString*) state
              Uid:(NSString*) uid
              PageSize:(NSInteger) pagesize
              PageNum:(NSInteger) pagenum
              Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
      completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.25 获取用户参与活动列表
-(void) userJoinedEventList:(NSString*) state
                    Uid:(NSString*) uid
                    PageSize:(NSInteger) pagesize
                    PageNum:(NSInteger) pagenum
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;
///1.26 获取事件图片列表
-(void) eventPictureList:(NSString*) eid
                 PageSize:(NSInteger) pagesize
                 PageNum:(NSInteger) pagenum
                 Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.27 获取用户喜好列表
- (void)getUserLikeList:(NSString *)uid
         Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.28 增加用户喜好列表
- (void)addUserEvent:(NSString *)uid
             Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
     completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.29 删除用户喜好列表
- (void)deleteUserLike:(NSString *)uid
               Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
       completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

///1.30 获取用户收藏事件列表
- (void)getUserTreasureList:(NSInteger)uid
                   PageSize:(NSInteger) pagesize
                    PageNum:(NSInteger) pagenum
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.31 增加用户喜好事件
- (void)addUserLikeEvent:(NSInteger)uid
                     eid:(NSInteger)eid
                    attr:(NSInteger)attr
                 Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.32 删除用户喜好事件
- (void)deleteUserLikeEvent:(NSInteger)uid
                        eid:(NSInteger)eid
                       attr:(NSInteger)attr
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.33 获取事件评论
- (void)getEventComment:(NSInteger)eid
               PageSize:(NSInteger) pagesize
                PageNum:(NSInteger) pagenum
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.34 增加评论
- (void)addEventComment:(NSInteger)commentid
                News_id:(NSInteger)News_id
                content:(NSString *)content
              commenter_id:(NSInteger)commenter_id
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.35 删除评论
- (void)deleteEventComment:(NSInteger)comment_id
                   Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.36 获取GO WITH ORANGER事件列表

- (void)getGoWithOranger:(NSInteger) pagesize
                 PageNum:(NSInteger) pagenum
                   State:(NSInteger) state
                 Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

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
         completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;


//1.38 删除GO WITH ORANGER事件列表
- (void)deleteGoWithOranger:(NSInteger)eid
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.39 获取oranger活动人员
- (void)getOrangeMember:(NSInteger)eid
          schedule_date:(NSString *)schedule_date
               pagesize:(NSInteger)pagesize
                pagenum:(NSInteger)pagenum
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.40 添加oranger活动人员AddOrangerMember
- (void)addOrangeMember:(NSInteger)oid
                    EID:(NSInteger)EID
                    UID:(NSInteger)UID
          SCHEDULE_DATE:(NSString *)SCHEDULE_DATE
             APPLY_DATE:(NSString *)APPLY_DATE
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.41 删除OrangerMember
- (void)deleteOrangeMember:(NSInteger)oid
                   Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.42 获取用户参与的GO WITH ORANGER事件列表
- (void)getGoWithOrangerByUID:(NSInteger)uid
                        state:(NSInteger)state
                     pagesize:(NSString *)pagesize
                      pagenum:(NSString *)pagenum
                      Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
              completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.43 创建群聊
- (void)createChatGroup:(NSString *)groupname
          descscription:(NSString *)descscription
                  owner:(NSString *)owner
               maxusers:(NSInteger)maxusers
                members:(NSString *)members
            grouppublic:(NSString *)grouppublic
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.44更新群聊图片
- (void)updateChatgroupPicUrl:(NSString *)groupid
                  grouppicurl:(NSString *)grouppicurl
                      Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
              completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;
//1.45获取群成员
- (void)getChatGroupMembers:(NSString *)groupid
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;
//1.46 添加单个群成员
- (void)addChatGroupMember:(NSString *)groupid
                  username:(NSString *)username
                   Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;
//1.47 添加多个群成员
- (void)addChatGroupMembers:(NSString *)groupid
                      users:(NSString *)users
                    Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
            completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;
//1.48 删除群成员
- (void)deleteChatGroupMember:(NSString *)groupid
                     username:(NSString *)username
                      Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
              completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;
//1.49 获取用户参与的群
//1.50 转让群组
- (void)ChangeChatGroupOwner:(NSString *)groupid
                    username:(NSString *)username
                     Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
             completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.51 删除群组
- (void)deleteChatGroup:(NSString *)groupid
                Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
        completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

@end
