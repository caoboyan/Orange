//
//  RegStep4.m
//  Orange
//
//  Created by Aiwa on 3/28/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "RegStep4.h"
#import "RegStep5.h"

@interface RegStep4 ()
{
    UIView* _male;
    UIView* _female;
    NSString* _gender;
}

@end

@implementation RegStep4

@synthesize email,mobile, firstName,sunName,picture,birthDay,address;

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
    txt.text = @"What's Your Gender?";
    [self.view addSubview:txt];
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(@90);
        make.height.equalTo(@14);
    }];
    
   
    _male = [[UIView alloc] init];
    _male.backgroundColor = [UIColor whiteColor];
    _male.layer.cornerRadius = 5.0f;
    _male.layer.masksToBounds = YES;
    UITapGestureRecognizer* tapMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedMale)];
    _male.userInteractionEnabled = YES;
    [_male addGestureRecognizer:tapMale];
    [self.view addSubview:_male];
    [_male mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 80));
        make.top.equalTo(txt.mas_bottom).offset(20);
        make.left.equalTo(@40);
    }];
    
    UILabel* lmale = [[UILabel alloc] init];
    lmale.text = @"Male";
    lmale.textAlignment = NSTextAlignmentCenter;
    lmale.font = [UIFont systemFontOfSize:13];
    lmale.textColor = ORANGE_C;
    [_male addSubview:lmale];
    [lmale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_male);
        make.right.equalTo(_male);
        make.height.equalTo(@13);
        make.bottom.equalTo(_male).offset(-5);
    }];
    
    
    
    _female = [[UIView alloc] init];
    _female.backgroundColor = [UIColor whiteColor];
    _female.layer.cornerRadius = 5.0f;
    _female.layer.masksToBounds = YES;
    UITapGestureRecognizer* tapFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedFemale)];
    _female.userInteractionEnabled = YES;
    [_female addGestureRecognizer:tapFemale];
    [self.view addSubview:_female];
    [_female mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 80));
        make.top.equalTo(txt.mas_bottom).offset(20);
        make.right.equalTo(@-40);
    }];
    
    UILabel* lfemale = [[UILabel alloc] init];
    lfemale.text = @"Female";
    lfemale.textAlignment = NSTextAlignmentCenter;
    lfemale.font = [UIFont systemFontOfSize:13];
    lfemale.textColor = ORANGE_C;
    [_female addSubview:lfemale];
    [lfemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_female);
        make.right.equalTo(_female);
        make.height.equalTo(@13);
        make.bottom.equalTo(_female).offset(-5);
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

-(void) touchedMale
{
    _male.backgroundColor = [UIColor orangeColor];
    _female.backgroundColor = [UIColor whiteColor];
    _gender = @"male";
}

-(void) touchedFemale
{
    _female.backgroundColor = [UIColor orangeColor];
    _male.backgroundColor = [UIColor whiteColor];
    _gender = @"female";
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
    if ([StringUtil nullStr:_gender]) {
        [self alertError:@"please select your gender"];
        return;
    }
    RegStep5 *ctrl = [[RegStep5 alloc] init];
    ctrl.email = self.email;
    ctrl.mobile = self.mobile;
    ctrl.firstName = self.firstName;
    ctrl.sunName = self.sunName;
    ctrl.picture = self.picture;
    ctrl.birthDay = self.birthDay;
    ctrl.address = self.address;
    ctrl.gender = _gender;
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
