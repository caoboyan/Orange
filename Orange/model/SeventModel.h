//
//  SeventModel.h
//  Orange
//
//  Created by Aiwa on 3/24/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface SeventModel : NSObject

@property(nonatomic) NSInteger eid;
@property(nonatomic, retain) NSString* etype;
@property(nonatomic, retain) NSString* Topic;
@property(nonatomic, retain) NSString* Content;
@property(nonatomic) NSInteger Max_num;
@property(nonatomic, retain) NSString* COSTS;
@property(nonatomic, retain) NSString* ADDRESS;
@property(nonatomic, retain) NSString* STARTDATE;
@property(nonatomic, retain) NSString* STOPDATE;
@property(nonatomic, retain) NSString* longitude;
@property(nonatomic, retain) NSString* latitude;
@property(nonatomic) NSInteger owner_uid;
@property(nonatomic) NSInteger Current_num;
@property(nonatomic, retain) NSString* state;
@property(nonatomic, retain) NSString* date;
@property(nonatomic, retain) NSString* picture;

+(SeventModel*) fromDict:(NSDictionary*) dict;

+(NSArray*) fromArray:(NSArray*) array;

@end
