//
//  SuserModel.h
//  Sword
//
//  Created by Aiwa on 12/23/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface SuserModel : NSObject <NSCoding>

@property(nonatomic) NSInteger uid;
@property(nonatomic, retain) NSString* utype;
@property(nonatomic, retain) NSString* userid;
@property(nonatomic, retain) NSString* pwd;
@property(nonatomic, retain) NSString* uname;
@property(nonatomic, retain) NSString* birthday;
@property(nonatomic, retain) NSString* sex;
@property(nonatomic, retain) NSString* rank;
@property(nonatomic, retain) NSString* address;
@property(nonatomic, retain) NSString* email;
@property(nonatomic, retain) NSString* mobile;
@property(nonatomic, retain) NSString* jointime;
@property(nonatomic, retain) NSString* logintime;
@property(nonatomic, retain) NSString* Picture;

+(SuserModel*) fromDict:(NSDictionary*) dict;

+(NSArray*) fromArray:(NSArray*) array;

@end
