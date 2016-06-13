//
//  EventNearbyCell.h
//  Orange
//
//  Created by Aiwa on 4/8/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SeventModel.h"
#import "SeventModel.h"

#import "EventsIndexController.h"

@interface EventNearbyCell : UITableViewCell

@property (nonatomic, weak) EventsIndexController* eventsController;

+(CGFloat) cellHeight;

-(void) cellContent:(NSArray*) array;

-(void) cellTag:(NSInteger) tag;

@end
