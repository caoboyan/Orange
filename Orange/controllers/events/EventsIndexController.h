//
//  EventsIndexController.h
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "CommonViewController.h"

@interface EventsIndexController : CommonViewController

-(void) touchedRecommendHeart:(NSInteger) idx;
-(void) touchedNearbyHeart:(NSInteger) idx;
-(void) touchedNearbyFrame:(NSInteger) idx;

@end
