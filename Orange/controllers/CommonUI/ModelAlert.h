//
//  ModelAlert.h
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "CommonLayer.h"

//enum {
//    AlertTypeMessage,
//    AlertTypeError,
//    AlertTypeChoice,
//} AlertType;

typedef NS_ENUM(NSInteger, AlertType) {
    AlertTypeMessage = 0,
    AlertTypeError = 1,
    AlertTypeChoice = 2
};

@interface ModelAlert : CommonLayer
- (instancetype)initWithFrame:(CGRect)frame
                         Text:(NSString*) text
                         Icon:(AlertType) icon
                           OK: (void (^)())ok
                       Cancel: (void(^)()) cancel;

@end
