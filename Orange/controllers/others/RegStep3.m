//
//  RegStep3.m
//  Orange
//
//  Created by Aiwa on 3/28/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "RegStep3.h"

#import "RegStep4.h"

#import "ModelDatePicker.h"

@interface RegStep3 ()<CustomDatePickerProtocol, UITextFieldDelegate>
{
    UILabel* _birthDay;
    UITextField* _address;
}

@end

@implementation RegStep3

@synthesize email, mobile, firstName, sunName, picture;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wbt_colorWithHexValue:0xECEDF1 alpha:1];
    self.navigationController.navigationBar.hidden = YES;
    
    UIView* line1 = [self addLine];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
    }];
    
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orange_logo"]];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(129, 30));
        make.bottom.equalTo(line1.mas_top).offset(-5);
    }];
    
    UILabel* left = [[UILabel alloc] init];
    left.textAlignment = NSTextAlignmentLeft;
    left.font = [UIFont boldSystemFontOfSize:13];
    left.textColor = ORANGE_C;
    left.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedLeft)];
    [left addGestureRecognizer:tapLeft];
    left.text = @"BACK";
    [self.view addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.height.equalTo(@35);
        make.top.equalTo(@25);
        make.width.equalTo(@120);
    }];
    
    UILabel* right = [[UILabel alloc] init];
    right.textAlignment = NSTextAlignmentRight;
    right.font = [UIFont boldSystemFontOfSize:13];
    right.textColor = ORANGE_C;
    right.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedRight)];
    [right addGestureRecognizer:tapRight];
    right.text = @"NEXT";
    [self.view addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@35);
        make.top.equalTo(@25);
        make.width.equalTo(@120);
    }];
    
    
    UILabel* txt = [[UILabel alloc] init];
    txt.font = [UIFont systemFontOfSize:14];
    txt.textColor = ORANGE_C;
    txt.userInteractionEnabled = YES;
    txt.text = @"What's Your Birthday?";
    [self.view addSubview:txt];
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(@90);
        make.height.equalTo(@14);
    }];
    
    _birthDay = [[UILabel alloc] init];
    _birthDay.font = [UIFont systemFontOfSize:13];
    _birthDay.textAlignment = NSTextAlignmentCenter;
    _birthDay.textColor = ORANGE_C;
    _birthDay.backgroundColor = [UIColor whiteColor];
    _birthDay.layer.masksToBounds = YES;
    _birthDay.layer.cornerRadius = 5.0f;
    _birthDay.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapBirth = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedBirth)];
    [_birthDay addGestureRecognizer:tapBirth];
    [self.view addSubview:_birthDay];
    [_birthDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.left.equalTo(self.view).offset(15);
        make.height.equalTo(@30);
        make.top.equalTo(txt.mas_bottom).offset(8);
    }];
    
    
    UILabel* txt2 = [[UILabel alloc] init];
    txt2.font = [UIFont systemFontOfSize:14];
    txt2.textColor = ORANGE_C;
    txt2.userInteractionEnabled = YES;
    txt2.text = @"Your Address";
    [self.view addSubview:txt2];
    [txt2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(_birthDay.mas_bottom).offset(20);
        make.height.equalTo(@14);
    }];
    
    _address = [[UITextField alloc] init];
    _address.font = [UIFont systemFontOfSize:12];
    _address.returnKeyType = UIReturnKeyDone;
    _address.layer.masksToBounds = YES;
    _address.layer.cornerRadius = 5.0f;
    _address.backgroundColor = [UIColor whiteColor];
    _address.delegate = self;
    [self.view addSubview:_address];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(txt2.mas_bottom).offset(8);
        make.height.equalTo(@30);
    }];

    
    UIView* line3 = [self addLine];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-45);
    }];
    
    UILabel* login = [[UILabel alloc] init];
    login.textAlignment = NSTextAlignmentLeft;
    login.font = [UIFont systemFontOfSize:13];
    login.textColor = ORANGE_C;
    login.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapLose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedLogin)];
    [login addGestureRecognizer:tapLose];
    login.text = @"Already have a account?";
    [self.view addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(line3.mas_bottom).offset(15);
        make.height.equalTo(@16);
    }];
    
    
}

-(void) touchedRight
{
    [self commit];
}

-(void) touchedLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) touchedLogin
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) touchedBirth
{
    ModelDatePicker* picker = [[ModelDatePicker alloc] initWithFrame:CGRectZero DateType:UIDatePickerModeDate];
    picker.delegate = self;
}


-(UIView*) addLine
{
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = ORANGE_C;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(14);
        make.right.equalTo(self.view).offset(-14);
        make.height.equalTo(@2);
    }];
    return line;
}



-(void) commit
{
    NSString* birthStr = _birthDay.text;
    NSString* addressStr = _address.text;
    if ([StringUtil nullStr:birthStr]) {
        [self alertError:@"Please select your birthday"];
        return;
    }
    if ([StringUtil nullStr:addressStr]) {
        [self alertError:@"Please input your Address"];
        return;
    }
    
    RegStep4 *ctrl = [[RegStep4 alloc] init];
    
    ctrl.email = self.email;
    ctrl.mobile = self.mobile;
    ctrl.firstName = self.firstName;
    ctrl.sunName = self.sunName;
    ctrl.picture = self.picture;
    ctrl.birthDay = birthStr;
    ctrl.address = addressStr;
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark === delegate of xxx
-(void) customDatePickerDidDChanged:(UIDatePicker*) picker
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString* birthday = [dateFormatter stringFromDate:picker.date];
    _birthDay.text = birthday;
}
-(void) customDatePickerOkDidClicked:(UIDatePicker*) picker
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString* birthday = [dateFormatter stringFromDate:picker.date];
    _birthDay.text = birthday;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    //    [_email resignFirstResponder];
    return YES;
}

@end
