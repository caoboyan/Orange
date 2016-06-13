//
//  DateLabel.m
//  Teeeeeeeee
//
//  Created by Aiwa on 3/29/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "DateLabel.h"
#import "NSDate+Category.h"

@interface DateLabel()
{
    NSDate* _date;
}

@end

@implementation DateLabel



- (instancetype)initWithFrame:(CGRect)frame WithDate:(NSDate*) date
{
    self = [super initWithFrame:frame];
    if (self) {
        _date = date;
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    NSArray* months = @[@"",@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",
                @"Oct",@"Nov",@"Dec"];
    self.backgroundColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:12];
    if (_date.day != 1) {
        self.text = [NSString stringWithFormat:@"%ld", _date.day];
        self.textColor = [UIColor orangeColor];
    }else {
        self.text = [months objectAtIndex:_date.month];
        self.textColor = [UIColor redColor];
    }
    
    if ([self canChoice]) {
        self.backgroundColor = [UIColor whiteColor];
    }else {
        self.backgroundColor = [UIColor grayColor];
    }
}

-(BOOL) canChoice
{
    NSDate* date = [NSDate date];
    NSInteger minitusForNow = [date minutesBeforeDate:_date];
    return minitusForNow >= 0;
}

-(void) setSingle
{
    self.backgroundColor = [UIColor blueColor];
}

-(void) setFirst
{
    self.backgroundColor = [UIColor orangeColor];
}

-(void) setLast
{
    self.backgroundColor = [UIColor orangeColor];
}

-(void) setMiddle
{
    self.backgroundColor = [UIColor greenColor];
}
-(void) setClear
{
    self.backgroundColor = [UIColor whiteColor];
}

-(NSDate*) getDate
{
    return _date;
}


@end
