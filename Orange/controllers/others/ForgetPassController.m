//
//  ForgetPassController.m
//  Orange
//
//  Created by Aiwa on 3/28/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "ForgetPassController.h"

@interface ForgetPassController () <UITextFieldDelegate>
{
    UITextField* _email;
}

@end

@implementation ForgetPassController

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
    right.text = @"SEND EMAIL";
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
    txt.text = @"Input your Email";
    [self.view addSubview:txt];
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(@90);
        make.height.equalTo(@14);
    }];
    
    _email = [[UITextField alloc] init];
    _email.font = [UIFont systemFontOfSize:12];
    _email.returnKeyType = UIReturnKeyDone;
    _email.layer.masksToBounds = YES;
    _email.layer.cornerRadius = 5.0f;
    _email.backgroundColor = [UIColor whiteColor];
    _email.delegate = self;
    [self.view addSubview:_email];
    [_email mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(txt.mas_bottom).offset(8);
        make.height.equalTo(@30);
    }];
    
    UILabel* stxt = [[UILabel alloc] init];
    stxt.font = [UIFont systemFontOfSize:12];
    stxt.textColor = ORANGE_C;
    stxt.numberOfLines = 0;
    stxt.text = @"TIPS: insert your email address and we'll help you to reset your password with an email.";
    [self.view addSubview:stxt];
    [stxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(_email.mas_bottom).offset(20);
        make.height.equalTo(@40);
    }];
    
    
    UIView* line3 = [self addLine];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-45);
    }];
    
    UILabel* login = [[UILabel alloc] init];
    login.textAlignment = NSTextAlignmentCenter;
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

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [_email resignFirstResponder];
    return YES;
}

-(void) commit
{
    NSString* emailStr = _email.text;
    if (emailStr.length < 4 || ![StringUtil containsString:emailStr checkedStr:@"@"]) {
        [self alertError:@"please insert correct email"];
        return;
    }
    
    ///TODO ....
}





@end
