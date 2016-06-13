//
//  Skeychain.m
//  Candy2
//
//  Created by Aiwa on 11/27/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "Skeychain.h"

@implementation Skeychain


+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service account:(NSString *)acc{
    NSMutableDictionary *dicx = [NSMutableDictionary dictionaryWithObjectsAndKeys:
        (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,nil];
    if (acc) {
        dicx[(__bridge_transfer id)kSecAttrAccount]=acc;
    }
    if (service) {
        dicx[(__bridge_transfer id)kSecAttrService]=service;
    }
    return dicx;
}

+ (void)save:(NSString *)service account:(NSString *)acc data:(NSData *)data
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service account:acc];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:data forKey:(__bridge_transfer id)kSecValueData];
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (void)save:(NSString *)service data:(id)data {
    [[self class] save:service account:service data:data];
}

+ (NSData *)load:(NSString *)service account:(NSString *)acc
{
    NSData *ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service account:acc];
    [keychainQuery setObject:(__bridge_transfer id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        ret = (__bridge_transfer NSData*)keyData;
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (NSData *)load:(NSString *)service {
    return [[self class] load:service account:service];
}

+ (void)delete:(NSString *)service {
    return [[self class] delete:service account:service];
}

+ (void)delete:(NSString *)service account:(NSString *)acc
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service account:acc];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

@end
