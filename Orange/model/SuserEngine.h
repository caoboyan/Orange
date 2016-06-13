//
//  SuserEngine.h
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SbasicEngine.h"

#import "SmessageFriend.h"
#import "SmessageGroup.h"

@interface SuserEngine : SbasicEngine

/// user login
-(void) userLogin:(NSString*) userName Password:(NSString*) passwd Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
  completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

/// login with facebook ....
-(void) userFacebookLobin:(NSString*) userid UserName:(NSString*) username Avatar:(NSString*) avatar Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
          completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

/// user change password
-(void) userChangePassword:(NSString*) userName Password:(NSString*) passwd NewPassword:(NSString*) newpwd Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

/// Add new Use ...
-(void) userAddNew:(NSString*) pwd UserName:(NSString*) uname BirthDar:(NSString*) birthday
               Sex:(NSString*) sex Address:(NSString*) address Email:(NSString*)email
             Moile:(NSString*) mobile Pic:(NSString*) Picture
           Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
   completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

/// user change info by email
-(void) userUpdateByEmail:(NSString*) email Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
          completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

-(void) uploadImage:(UIImage*) image
        ExtraParams:(NSDictionary*) extraParams
    completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler;

//1.22获取好友列表
-(void) friendList:(NSString*) state
               Uid:(NSString*) uid
          PageSize:(NSInteger) pagesize
           PageNum:(NSInteger)pagenum
           Encrypt:(NSString*) encrypt
             Extra:(NSDictionary*) extra
   completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;

//1.23 删除好友
-(void) deleteFriend:(NSString*) state
                MyId:(NSString*) my_id
            FriendId:(NSString*) friend_id
             Encrypt:(NSString*) encrypt
               Extra:(NSDictionary*) extra
     completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler ;


@end
