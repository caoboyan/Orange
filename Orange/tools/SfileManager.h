//
//  SfileManager.h
//  Candy2
//
//  Created by Aiwa on 12/3/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SfileManager : NSObject

+(void) downloadFile:(NSString*) url Block:(void(^)(BOOL success, NSError *error )) block;

+(void) convertFile:(NSString*) fileName;

+(void) clearTempDirectoryMp3File;

+(void) clearDocMp3File;

@end
