//
//  RegStep5.m
//  Orange
//
//  Created by Aiwa on 3/28/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "RegStep5.h"
#import "SuserEngine.h"

@interface RegStep5 ()<UITextFieldDelegate>
{
    UITextField* _password;
    UITextField* _repassword;
}

@end

@implementation RegStep5

@synthesize email,mobile,firstName,sunName,picture,birthDay,address,gender;

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
    right.text = @"Finish";
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
    txt.text = @"Create A Password";
    [self.view addSubview:txt];
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(@90);
        make.height.equalTo(@14);
    }];
    
    _password = [[UITextField alloc] init];
    _password.font = [UIFont systemFontOfSize:12];
    _password.returnKeyType = UIReturnKeyNext;
    _password.secureTextEntry = YES;
    _password.layer.masksToBounds = YES;
    _password.layer.cornerRadius = 5.0f;
    _password.backgroundColor = [UIColor whiteColor];
    _password.delegate = self;
    UIView* left1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    _password.leftView = left1;
    _password.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(txt.mas_bottom).offset(8);
        make.height.equalTo(@30);
    }];
    
    UILabel* txt2 = [[UILabel alloc] init];
    txt2.font = [UIFont systemFontOfSize:14];
    txt2.textColor = ORANGE_C;
    txt2.userInteractionEnabled = YES;
    txt2.text = @"Repeat The Password";
    [self.view addSubview:txt2];
    [txt2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(_password.mas_bottom).offset(25);
        make.height.equalTo(@14);
    }];
    
    _repassword = [[UITextField alloc] init];
    _repassword.font = [UIFont systemFontOfSize:12];
    _repassword.returnKeyType = UIReturnKeyNext;
    _repassword.secureTextEntry = YES;
    _repassword.layer.masksToBounds = YES;
    _repassword.layer.cornerRadius = 5.0f;
    _repassword.backgroundColor = [UIColor whiteColor];
    _repassword.delegate = self;
    UIView* left2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    _repassword.leftView = left2;
    _repassword.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_repassword];
    [_repassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(txt2.mas_bottom).offset(8);
        make.height.equalTo(@30);
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


-(void) commit
{
    NSString* password = _password.text;
    NSString* passwordRe = _repassword.text;
    if ([StringUtil nullStr:password] || [StringUtil nullStr:passwordRe]) {
        [self alertError:@"Please insert correct password"];
        return;
    }
    
    if (![password isEqualToString:passwordRe]) {
        [self alertError:@"Please insert the same password"];
        return;
    }
    
    NSString* username = [NSString stringWithFormat:@"%@ %@",self.firstName, self.sunName];
    
    SuserEngine* engine = [[SuserEngine alloc] init];
    [engine userAddNew:password UserName:username BirthDar:self.birthDay Sex:self.gender Address:self.address Email:self.email Moile:self.mobile Pic:self.picture Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            NSArray* arr = (NSArray*) data;
            SuserModel *user = [arr firstObject];
            user.uid = 45;
            [[SaccountStore sharedInstance] resetCurrentAccount:user];
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"KEY_EASEMOB_NDEDS_LOGIN" object:@{@"flag":@"login"}];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KEY_LOGINSTATE_CHANGE" object:@{@"flag":@"login"}];
            NSLog(@"123123 %@",data);
        }else {
            [self requestError:error];
        }
    }];
}

@end
