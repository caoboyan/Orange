//
//  SmessageFriend.h
//  Orange
//
//  Created by Aiwas on 5/11/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface SmessageFriend : NSObject

@property(nonatomic) NSString* UID;
@property(nonatomic, retain) NSString* UNAME;
@property(nonatomic, retain) NSString* SEX;
@property(nonatomic, retain) NSString* BIRTHDAY;
@property(nonatomic, retain) NSString* EMAIL;
@property(nonatomic, retain) NSString* PICTURE;
@property(nonatomic, retain) NSString* STATE;

// from
@property (nonatomic) NSInteger unreadCount;
@property (nonatomic, retain) NSString* detailMsg;
@property (nonatomic, retain) NSString* time;


+(SmessageFriend*) fromDict:(NSDictionary*) dict;

+(NSArray*) fromArray:(NSArray*) array;

@end
