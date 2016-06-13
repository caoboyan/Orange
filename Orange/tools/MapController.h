//
//  MapController.h
//  MapTest
//
//  Created by Aiwa on 5/10/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol addrSelectDelegate <NSObject>

-(void) didAddrSelected:(NSDictionary*) addr;

@end

@interface MapController : UIViewController

@property (nonatomic, weak) id<addrSelectDelegate> delegate;

@end
