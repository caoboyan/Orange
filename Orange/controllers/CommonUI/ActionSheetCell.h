//
//  ActionSheetCell.h
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionSheetCell : UITableViewCell

-(void) cellWidth:(CGFloat) width;

-(void) cellContent:(NSString*) content Color:(int) color;

-(void) hideLine;

@end
