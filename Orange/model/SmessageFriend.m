//
//  SmessageFriend.m
//  Orange
//
//  Created by Aiwas on 5/11/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SmessageFriend.h"

@implementation SmessageFriend

+(SmessageFriend*) fromDict:(NSDictionary*) dict
{
    SmessageFriend *model = [SmessageFriend yy_modelWithDictionary:dict];
    return model;
}

+(NSArray*) fromArray:(NSArray*) array
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in array) {
        SmessageFriend *model = [SmessageFriend fromDict:dict];
        [arr addObject:model];
    }
    return [NSArray arrayWithArray:arr];
}

@end
