//
//  ModelDatePicker.m
//  Candy2
//
//  Created by Aiwa on 11/4/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "ModelDatePicker.h"

@interface ModelDatePicker()
{
    UIDatePicker *picker;
}

@end

@implementation ModelDatePicker

- (instancetype)initWithFrame:(CGRect)frame DateType:(UIDatePickerMode) dateModel
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setHeader];
        [self setPicker:dateModel];
    }
    return self;
}


-(void) setHeader
{
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, 44)];
    UIButton* btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCancel.frame = CGRectMake(0, 0, 80, 44);
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(datePickerCancelClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* btnOk = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnOk.frame = CGRectMake(self.sframe.wbtWidth-80, 0, 80, 44);
    [btnOk setTitle:@"确定" forState:UIControlStateNormal];
    [btnOk addTarget:self action:@selector(datePickerOKClicked) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btnOk];
    [header addSubview:btnCancel];
    [self.sframe addSubview:header];
}

-(void) setPicker:(UIDatePickerMode) dateModel
{
    picker = [[UIDatePicker alloc] init];
    picker.frame = CGRectMake(0, 44, self.sframe.wbtWidth, 162);
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    picker.backgroundColor = [UIColor whiteColor];
//    picker.datePickerMode = UIDatePickerModeDate;
    picker.datePickerMode = dateModel;
    picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [picker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.sframe addSubview:picker];
    [self setSframeHeight: 162+44];
    NSDate* now = [[NSDate alloc]init];
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss Z";
    format.timeZone = [NSTimeZone localTimeZone] ;
    NSDate* beforeDate = [format dateFromString:@"1990-01-01 01:01:01 +0000"];
    picker.maximumDate = now;
    picker.minimumDate = beforeDate;
}

-(void)datePickerOKClicked
{
    if (self.delegate != nil) {
        [self.delegate customDatePickerOkDidClicked:picker];
    }
    [self hide];
}

-(void) datePickerCancelClicked
{
    [self hide];
}

-(void) dateChanged:(UIDatePicker*) datePicker
{
    if (self.delegate != nil) {
        [self.delegate customDatePickerDidDChanged:picker];
    }
}

@end
