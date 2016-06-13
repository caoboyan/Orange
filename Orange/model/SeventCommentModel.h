//
//  SeventCommentModel.h
//  Orange
//
//  Created by boyancao on 16/6/6.
//  Copyright © 2016年 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeventCommentModel : NSObject

@property (nonatomic, copy) NSString * comment_id;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * create_date;

@property (nonatomic, copy) NSString * event_id;

@property (nonatomic, copy) NSString * picture;

@property (nonatomic, copy) NSString * uid;

@property (nonatomic, copy) NSString * uname;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
