//
//  CalendarView.m
//  Teeeeeeeee
//
//  Created by Aiwa on 3/26/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#ifndef ______calendar_item_height
#define ______calendar_item_height
#define CALENDAR_ITEM_HEIGHT 35
#define CALENDAR_TITLE_HEIGHT 14
#endif

#import "CalendarView.h"
#import "DateLabel.h"
#import "NSDate+Category.h"

@interface CalendarView()
{
    NSInteger startIndex;
    NSInteger endIndex;
    NSArray* dates;
    
    NSDate* startDate;
    
    ///choiced date...
    NSInteger _selStart;
    NSInteger _selEnd;
    
}
@end

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selStart = _selEnd = -1;
        [self initDates];
        [self initViews];
        [self initDateView];
        [self initTips];
    }
    return self;
}

-(void) initDates
{
    NSDate* today = [NSDate date];
    NSInteger pres = today.weekday -1;
    startDate = [today dateBySubtractingDays:pres];
    NSDate* t__last = [today dateByAddingDays:30];
    NSInteger nexts = 7- t__last.weekday;
    NSInteger slength = pres + 30 + nexts + 1; /// 1 is today ...
    
    NSMutableArray* arr = [NSMutableArray array];
    for (int i=0; i<slength; i++) {
        NSDate* sd = [startDate dateByAddingDays:i];
        [arr addObject:sd];
    }
    dates = [NSArray arrayWithArray:arr];
}

-(void) initViews
{
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat sw = (screen_w - 8) / 7;
    NSArray* weekdayStr = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
    self.backgroundColor = [UIColor orangeColor];
    CGFloat left = 1;
    for (int i=0; i<7; i++) {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(left, 1, sw, CALENDAR_TITLE_HEIGHT)];
        lab.text = [weekdayStr objectAtIndex:i];
        lab.font = [UIFont systemFontOfSize:10];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
        left += sw + 1;
    }
}

-(void) initDateView
{
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat sw = (screen_w - 8) / 7;
    CGFloat sh = CALENDAR_ITEM_HEIGHT -2;
    CGFloat left = 1;
    CGFloat top = CALENDAR_TITLE_HEIGHT;
    for (int i=0; i<[dates count]; i++) {
        left  = i%7 * (sw+1) + 1;
        NSInteger tIdx = i/7;
        top = tIdx* CALENDAR_ITEM_HEIGHT + CALENDAR_TITLE_HEIGHT;
        NSDate* sdate = [dates objectAtIndex:i];
        DateLabel* dl = [[DateLabel alloc] initWithFrame:CGRectZero WithDate:sdate];
        dl.tag = 1999 + i;
        dl.frame = CGRectMake(left, top, sw, sh);
        [self addSubview:dl];
    }
}

-(void) initTips
{
    CGFloat sh =  [CalendarView viewHeight];
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0, sh-30, screen_w-80, 30)];
    lab.text = @"    plase slider to choice dates";
    lab.font = [UIFont systemFontOfSize:10];
    [self addSubview:lab];
    
    UIButton* sb = [UIButton buttonWithType:UIButtonTypeCustom];
    [sb setTitle:@"choice" forState:UIControlStateNormal];
    [sb setBackgroundColor:[UIColor orangeColor]];
    [sb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:sb];
    sb.frame = CGRectMake(screen_w-80, sh-32, 80, 32);
    sb.titleLabel.font = [UIFont systemFontOfSize:12];
    [sb addTarget:self action:@selector(touchedChoice) forControlEvents:UIControlEventTouchUpInside];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat sw = screen_w / 7;
    UITouch* touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    CGFloat sy = current.y - CALENDAR_TITLE_HEIGHT;
    CGFloat sx = current.x;
    NSInteger yIdx = sy/CALENDAR_ITEM_HEIGHT;
    NSInteger xIdx = sx/sw;
    NSInteger idx = yIdx*7 + xIdx;
    DateLabel* dl = (DateLabel*)[self viewWithTag:1999 + idx];
    if ([dl canChoice]) {
        _selStart = idx;
        _selEnd = idx;
        [self renderViews];
    }
}

-(void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    CGFloat sw = screen_w / 7;
    UITouch* touch = [touches anyObject];
    CGPoint current = [touch locationInView:self];
    CGFloat sy = current.y - CALENDAR_TITLE_HEIGHT;
    CGFloat sx = current.x;
    NSInteger yIdx = sy/CALENDAR_ITEM_HEIGHT;
    NSInteger xIdx = sx/sw;
    NSInteger idx = yIdx*7 + xIdx;
    DateLabel* dl = (DateLabel*)[self viewWithTag:1999 + idx];
    if ([dl canChoice]) {
        if (idx != _selEnd) {
            _selEnd = idx;
            [self renderViews];
        }
    }
}

-(void) renderViews
{
    NSInteger __start, __end;
    if (_selStart > _selEnd) {
        __start = _selEnd;
        __end = _selStart;
    }else {
        __start = _selStart;
        __end = _selEnd;
    }
    //clear selected .. //以后优化
    for (NSInteger i=0; i<142; i++) {
        DateLabel* dl = (DateLabel*) [self viewWithTag:1999 + i];
        if (dl != nil) {
            if ([dl canChoice]) {
                [dl setClear];
            }
        }
    }
    for (NSInteger i = __start; i<=__end; i++) {
        DateLabel* dl = (DateLabel*) [self viewWithTag:1999 + i];
        [dl setSingle];
    }
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void) touchedChoice
{
    if (self.delegate != nil && _selStart != -1) {
        DateLabel* st = (DateLabel*) [self viewWithTag:1999 + _selStart];
        DateLabel* se = (DateLabel*) [self viewWithTag:1999 + _selEnd];
        [self.delegate selectedDate:[st getDate]  EndDate:[se getDate]];
    }
    [self removeFromSuperview];
}


+(CGFloat) viewHeight
{
    NSDate* today = [NSDate date];
    NSInteger pres = today.weekday -1;
    NSDate* t__last = [today dateByAddingDays:30];
    NSInteger nexts = 7- t__last.weekday;
    NSInteger slength = pres + 30 + nexts + 1; /// 1 is today ...
    return slength/7 * CALENDAR_ITEM_HEIGHT + CALENDAR_TITLE_HEIGHT + 30;
}



@end
