//
//  SaccountStore.m
//  Candy2
//
//  Created by Aiwa on 11/2/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "SaccountStore.h"

static SaccountStore* instanceOnce = nil;

@interface SaccountStore()

@property (nonatomic, retain) SuserModel* currentAccount;
@end


static SaccountStore* instanceOnce;

@implementation SaccountStore

+(SaccountStore*) sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceOnce = [[self alloc] init];
    });
    return instanceOnce;
}

-(SuserModel*) getCurrentAccount
{
    @synchronized(self) {
        if (self.currentAccount == nil || [StringUtil nullStr:self.currentAccount.userid]) {
            @try {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"KEY_ACCOUNT"];
                if (data!=nil) {
                    SuserModel *acc = (SuserModel*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
                    self.currentAccount = acc;
                }
            }
            @catch (NSException *exception) {
            }
            @finally {
            }
        }
        return self.currentAccount;
    }
}

-(void) resetCurrentAccount:(SuserModel*) model
{
    self.currentAccount = model;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"KEY_ACCOUNT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString*) getCurrentUid
{
    return [NSString stringWithFormat:@"%ld", self.currentAccount.uid];
}

-(void) removeCurrentAccount
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KEY_ACCOUNT"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KEY_USER_PASS"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.currentAccount = nil;
}













@end
