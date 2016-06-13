//
//  SeventModel.m
//  Orange
//
//  Created by Aiwa on 3/24/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "SeventModel.h"

@implementation SeventModel

+(SeventModel*) fromDict:(NSDictionary*) dict
{
    SeventModel *model = [SeventModel yy_modelWithDictionary:dict];
    return model;
}

+(NSArray*) fromArray:(NSArray*) array
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in array) {
        SeventModel *model = [SeventModel fromDict:dict];
        [arr addObject:model];
    }
    return [NSArray arrayWithArray:arr];
}

//+(SeventModel*) testModel
//{
//    SeventModel* model = [[SeventModel alloc] init];
//    
//    model.eid = 2246;
//    @property(nonatomic, retain) NSString* etype;
//    @property(nonatomic, retain) NSString* Topic;
//    @property(nonatomic, retain) NSString* Content;
//    @property(nonatomic) NSInteger Max_num;
//    @property(nonatomic, retain) NSString* COSTS;
//    @property(nonatomic, retain) NSString* ADDRESS;
//    @property(nonatomic, retain) NSString* STARTDATE;
//    @property(nonatomic, retain) NSString* STOPDATE;
//    @property(nonatomic, retain) NSString* longitude;
//    @property(nonatomic, retain) NSString* latitude;
//    @property(nonatomic) NSInteger owner_uid;
//    @property(nonatomic) NSInteger Current_num;
//    @property(nonatomic, retain) NSString* state;
//    @property(nonatomic, retain) NSString* date;
//    @property(nonatomic, retain) NSString* picture;
//}

@end
