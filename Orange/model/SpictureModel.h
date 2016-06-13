//
//  SpictureModel.h
//  Orange
//
//  Created by Aiwa on 4/25/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface SpictureModel : NSObject


//":[{"picture_id":20,"news_id":0,"pic_url":"BodyPart_9a882be4-35ef-458e-9256-61002a70e9ee.jpg","event_id":4,"kind":"1"},{"



@property(nonatomic, retain) NSString* picture_id;
@property(nonatomic, retain) NSString* news_id;
@property(nonatomic, retain) NSString* pic_url;

@property(nonatomic, retain) NSString* event_id;
@property(nonatomic, retain) NSString* kind;

+(SpictureModel*) fromDict:(NSDictionary*) dict;

+(NSArray*) fromArray:(NSArray*) array;

@end
