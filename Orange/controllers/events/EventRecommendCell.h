//
//  EventRecommendCell.h
//  Orange
//
//  Created by Aiwa on 4/8/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeventModel.h"

#import "EventsIndexController.h"

//@class EventsIndexController;

@interface EventRecommendCell : UITableViewCell

@property (nonatomic, weak) EventsIndexController* eventsController;

+(CGFloat) cellHeight;

-(void) cellContent:(SeventModel*) model;

-(void) cellTag:(NSInteger) tag;

@end
