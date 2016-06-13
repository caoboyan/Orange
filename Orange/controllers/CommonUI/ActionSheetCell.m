//
//  ActionSheetCell.m
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "ActionSheetCell.h"

@interface ActionSheetCell ()

@property (nonatomic, retain) UILabel *slabel;
@property (nonatomic, retain) UIView *line;

@end

@implementation ActionSheetCell


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void) initView
{
    self.backgroundColor = [UIColor whiteColor];
    self.slabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 43)];
    self.slabel.font = [UIFont systemFontOfSize:16];
    self.slabel.textColor = [UIColor darkGrayColor];
    self.slabel.textAlignment = NSTextAlignmentCenter;
    self.slabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.slabel];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(30, self.slabel.wbtBottom, self.slabel.wbtWidth-30, 0.5)];
    self.line.backgroundColor = [UIColor wbt_colorWithHexValue:0xeeeeee alpha:1];
    [self addSubview:self.line];
}

-(void) cellWidth:(CGFloat) width
{
    self.frame = CGRectMake(0, 0, width, 44);
    self.slabel.wbtWidth = width;
    self.line.wbtWidth = width;
}

-(void) cellContent:(NSString*) content Color:(int) color
{
    self.slabel.text = content;
    self.slabel.textColor = [UIColor wbt_colorWithHexValue:color alpha:1];
}

-(void) hideLine
{
    self.line.hidden = YES;
}



@end
