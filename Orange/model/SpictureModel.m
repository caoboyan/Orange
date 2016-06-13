//
//  SpictureModel.m
//  Orange
//
//  Created by Aiwa on 4/25/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SpictureModel.h"

@implementation SpictureModel

+(SpictureModel*) fromDict:(NSDictionary*) dict
{
    SpictureModel *model = [SpictureModel yy_modelWithDictionary:dict];
    return model;
}

+(NSArray*) fromArray:(NSArray*) array
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in array) {
        SpictureModel *model = [SpictureModel fromDict:dict];
        [arr addObject:model];
    }
    return [NSArray arrayWithArray:arr];
}

@end
