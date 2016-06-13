//
//  MessageGroupCell.m
//  Orange
//
//  Created by Aiwas on 5/10/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "MessageGroupCell.h"

@implementation MessageGroupCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    
}

+(CGFloat) cellHeight
{
    return 0;
}

-(void) cellContent:(NSDictionary*) dict
{
    
}

@end
