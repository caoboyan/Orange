//
//  SuserEngine.m
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SuserEngine.h"

@implementation SuserEngine


/// login ....
-(void) userLogin:(NSString*) userName Password:(NSString*) passwd Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }

    [dict setObject:userName forKey:@"username"];
    [dict setObject:passwd forKey:@"passwd"];
    
    NSDictionary* finalDic = @{
                   @"func_name" : @"Login",
                   @"encrypt" : encrypt,
                   @"func_param" : dict
                };
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SuserModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// user change password
-(void) userChangePassword:(NSString*) userName Password:(NSString*) passwd NewPassword:(NSString*) newpwd Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
  completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:userName forKey:@"username"];
    [dict setObject:passwd forKey:@"passwd"];
    [dict setObject:newpwd forKey:@"newpwd"];
    
    NSDictionary* finalDic = @{
                               @"func_name" : @"ChangePasswd",
                               @"encrypt" : encrypt,
                               @"func_param" : dict
                               };
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    handler(data, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// Add new Use ...
-(void) userAddNew:(NSString*) pwd UserName:(NSString*) uname BirthDar:(NSString*) birthday
               Sex:(NSString*) sex Address:(NSString*) address Email:(NSString*)email
             Moile:(NSString*) mobile Pic:(NSString*) Picture
            Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    ///default values :
    [dict setObject:@4 forKey:@"uid"];
    [dict setObject:@"1" forKey:@"utype"];
    [dict setObject:@"1" forKey:@"userid"];
    [dict setObject:@1 forKey:@"rank"];
    //no default values:
    [dict setObject:pwd forKey:@"pwd"];
    [dict setObject:uname forKey:@"uname"];
    [dict setObject:birthday forKey:@"birthday"];
    [dict setObject:sex forKey:@"sex"];
    [dict setObject:email forKey:@"email"];
    
    if (![StringUtil nullStr:address]) {
        [dict setObject:address forKey:@"address"];
    }
    
    if (![StringUtil nullStr:mobile]) {
        [dict setObject:mobile forKey:@"mobile"];
    }
    
    if (![StringUtil nullStr:Picture]) {
        [dict setObject:Picture forKey:@"Picture"];
    }
    
    NSDictionary* finalDic = @{
                               @"func_name" : @"AddNewUser",
                               @"encrypt" : encrypt,
                               @"func_param" : dict
                               };
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SuserModel fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}


/// user change info by email
-(void) userUpdateByEmail:(NSString*) email Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
           completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:email forKey:@"email"];
    
    NSDictionary* finalDic = @{
                               @"func_name" : @"UpdateUserByEmail",
                               @"encrypt" : encrypt,
                               @"func_param" : dict
                               };
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    handler(data, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

/// login with facebook ....
-(void) userFacebookLobin:(NSString*) userid UserName:(NSString*) username Avatar:(NSString*) avatar Encrypt:(NSString*) encrypt Extra:(NSDictionary*) extra
  completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:username forKey:@"username"];
    [dict setObject:userid forKey:@"userid"];
    [dict setObject:avatar forKey:@"avatar"];
    NSDictionary* finalDic = @{
                               @"func_name" : @"AddFaceBookUser",
                               @"encrypt" : encrypt,
                               @"func_param" : dict
                               };
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SuserModel fromArray:arrData];
                    handler(arr, YES, nil);
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
            NSArray *arrData = (NSArray*) data;
            NSArray* arr = [SuserModel fromArray:arrData];
            handler(arr, YES, nil);
        }else{
            handler(nil, NO, error);
        }
    }];
}

//1.22获取好友列表
-(void) friendList:(NSString*) state
               Uid:(NSString*) uid
          PageSize:(NSInteger) pagesize
           PageNum:(NSInteger)pagenum
           Encrypt:(NSString*) encrypt
             Extra:(NSDictionary*) extra
          completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@"0" forKey:@"state"];
    [dict setObject:uid forKey:@"uid"];
    [dict setObject:[NSString stringWithFormat:@"%ld", pagesize] forKey:@"pagesize"];
    [dict setObject:[NSString stringWithFormat:@"%ld",pagenum] forKey:@"pagenum"];
    NSDictionary* finalDic = @{
                               @"func_name" : @"GetUserFriendsList",
                               @"encrypt" : encrypt,
                               @"func_param" : dict
                               };
    
    [self postNetworkRequst:nil parameters:finalDic
            completeHandler:^(AFHTTPRequestOperation *operation, id data, NSError *error) {
                if (error == nil) {
                    NSArray *arrData = (NSArray*) data;
                    NSArray* arr = [SmessageFriend fromArray:arrData];
                    handler(arr, YES, nil);
                }else{
                    handler(nil, NO, error);
                }
            }];
}

//1.23 删除好友
-(void) deleteFriend:(NSString*) state
               MyId:(NSString*) my_id
          FriendId:(NSString*) friend_id
           Encrypt:(NSString*) encrypt
             Extra:(NSDictionary*) extra
   completeHandler:(void(^)(id data, BOOL success, NSError* error)) handler {
    NSMutableDictionary *dict;
    if (extra == nil) {
        dict = [[NSMutableDictionary alloc] init];
    }else {
        dict = [[NSMutableDictionary alloc] initWithDictionary:extra];
    }
    
    [dict setObject:@"1" forKey:@"state"];
    [dict setObject:my_id forKey:@"my_id"];
    [dict setObject:friend_id forKey:@"friend_id"];
    NSDictionary* finalDic = @{
                               @"func_name" : @"DeleteUserFriend",
                               @"encrypt" : encrypt,
                               @"func_param" : dict
                               };
    
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



@end
