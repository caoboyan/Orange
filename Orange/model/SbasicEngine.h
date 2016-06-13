//
//  SbasicEngine.h
//  Candy2
//
//  Created by Aiwa on 10/31/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "URLheader.h"

@interface SbasicEngine : NSObject


-(void) getNetworkRequst:(NSString*) url parameters:(NSDictionary*) param completeHandler:(void(^)(AFHTTPRequestOperation* operation, id data, NSError* error)) handler;

-(void) postNetworkRequst:(NSString*) url parameters:(NSDictionary*) param completeHandler:(void(^)(AFHTTPRequestOperation* operation, id data, NSError* error)) handler;

-(void) postImageRequst:(NSString*) url parameters:(NSDictionary*) param Images:(NSDictionary*) images completeHandler: (void(^)(AFHTTPRequestOperation* operation, id data, NSError* error)) handler;

@end
