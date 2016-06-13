//
//  SmessageGroup.h
//  Orange
//
//  Created by Aiwas on 5/12/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface SmessageGroup : NSObject

@property(nonatomic) NSString* GID;
@property(nonatomic, retain) NSString* GNAME;

@property(nonatomic, retain) NSString* PICTURE;
@property(nonatomic, retain) NSString* STATE;

+(SmessageGroup*) fromDict:(NSDictionary*) dict;

+(NSArray*) fromArray:(NSArray*) array;

@end
