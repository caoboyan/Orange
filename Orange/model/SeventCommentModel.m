//
//  SeventCommentModel.m
//  Orange
//
//  Created by boyancao on 16/6/6.
//  Copyright © 2016年 Aiwa. All rights reserved.
//

#import "SeventCommentModel.h"

@implementation SeventCommentModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self =  [super init];
    if (self) {
        self.comment_id = (NSString *)[dic objectForKey:@"comment_id"];
        self.content = (NSString *)[dic objectForKey:@"content"];
        self.create_date = (NSString *)[dic objectForKey:@"create_date"];
        self.event_id = (NSString *)[dic objectForKey:@"event_id"];
        self.picture = (NSString *)[dic objectForKey:@"picture"];
        self.uid = (NSString *)[dic objectForKey:@"uid"];
        self.uname = (NSString *)[dic objectForKey:@"uname"];
    }
    return self;
}

@end
