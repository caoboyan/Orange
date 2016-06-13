//
//  Skeychain.h
//  Candy2
//
//  Created by Aiwa on 11/27/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

/**
 
 //写
 NSDictionary *userInfo = @{@"uname":@"name",@"pwd":@"111"};
 [CHKeychain save:@"userInfo" data:[NSKeyedArchiver archivedDataWithRootObject:userInfo]];
 //读
 NSData *userData =[CHKeychain load:@"userInfo"];
 NSLog(@"userInfo:%@",[NSKeyedUnarchiver unarchiveObjectWithData:userData]);
 **/
 

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface Skeychain : NSObject

+(void) save:(NSString *) service account:(NSString *) acc data:(NSData *) data;
+(void) save:(NSString *) service data:(NSData *) data;

+(NSData*) load:(NSString*) service;
+(NSData*) load:(NSString*) service account:(NSString *) acc;


+(void) delete:(NSString*) service;
+(void) delete:(NSString*) service account:(NSString *) acc;

@end
