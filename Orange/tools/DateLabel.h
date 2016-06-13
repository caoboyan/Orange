//
//  DateLabel.h
//  Teeeeeeeee
//
//  Created by Aiwa on 3/29/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame WithDate:(NSDate*) date;

-(BOOL) canChoice;

-(void) setSingle;

-(void) setFirst;

-(void) setLast;

-(void) setMiddle;

-(void) setClear;

-(NSDate*) getDate;




@end
