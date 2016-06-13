//
//  SmessageGroup.m
//  Orange
//
//  Created by Aiwas on 5/12/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SmessageGroup.h"

@implementation SmessageGroup

+(SmessageGroup*) fromDict:(NSDictionary*) dict
{
    SmessageGroup *model = [SmessageGroup yy_modelWithDictionary:dict];
    return model;
}

+(NSArray*) fromArray:(NSArray*) array
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in array) {
        SmessageGroup *model = [SmessageGroup fromDict:dict];
        [arr addObject:model];
    }
    return [NSArray arrayWithArray:arr];
}


@end
