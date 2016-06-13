//
//  MessageGroupCell.h
//  Orange
//
//  Created by Aiwas on 5/10/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageGroupCell : UITableViewCell

+(CGFloat) cellHeight;

-(void) cellContent:(NSDictionary*) dict;

@end
