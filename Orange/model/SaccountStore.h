//
//  SaccountStore.h
//  Candy2
//
//  Created by Aiwa on 11/2/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuserModel.h"

@interface SaccountStore : NSObject

+(SaccountStore*) sharedInstance;

-(void) resetCurrentAccount:(SuserModel*) model;
-(SuserModel*) getCurrentAccount;
-(NSString*) getCurrentUid;

-(void) removeCurrentAccount;



@end
