//
//  MessageFriendCell.h
//  Orange
//
//  Created by Aiwas on 5/10/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmessageFriend.h"

@interface MessageFriendCell : UITableViewCell

+(CGFloat) cellHeight;

-(void) cellContent:(SmessageFriend*) model;

@end
