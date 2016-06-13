//
//  LoginViewController.m
//  Orange
//
//  Created by Aiwa on 3/24/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "LoginViewController.h"
#import "RegStep1.h"
#import "ForgetPassController.h"

#import "EMSDK.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "SuserEngine.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField* _loginName;
    UITextField* _loginPass;
    
    UIView* iptFrm;
}

@end

@implementation LoginViewController

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
    
    UILabel* right = [[UILabel alloc] init];
    right.textAlignment = NSTextAlignmentRight;
    right.font = [UIFont systemFontOfSize:13];
    right.textColor = ORANGE_C;
    right.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedRight)];
    [right addGestureRecognizer:tapRight];
    right.text = @"Sign up";
    [self.view addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@35);
        make.bottom.equalTo(line1.mas_top);
        make.width.equalTo(@120);
    }];
    
//    UIButton* fb = [UIButton buttonWithType:UIButtonTypeCustom];
//    [fb setBackgroundColor:[UIColor wbt_colorWithHexValue:0x4A5DA5 alpha:1]];
//    fb.titleLabel.font = [UIFont systemFontOfSize:14];
//    fb.layer.masksToBounds = YES;
//    fb.layer.cornerRadius = 5.0f;
//    [fb setTitle:@"Log in with facebook" forState:UIControlStateNormal];
//    [fb addTarget:self action:@selector(loginFb) forControlEvents:UIControlEventTouchUpInside];
//    [fb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:fb];
//    [fb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(77);
//        make.right.equalTo(self.view).offset(-77);
//        make.top.equalTo(line1).offset(80);
//        make.height.equalTo(@29);
//    }];
    
//    UILabel* or = [[UILabel alloc] init];
//    or.textAlignment = NSTextAlignmentCenter;
//    or.font = [UIFont systemFontOfSize:13];
//    or.textColor = ORANGE_C;
//    or.userInteractionEnabled = YES;
//    or.text = @"Or";
//    [self.view addSubview:or];
//    [or mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.view).offset(77);
//                make.right.equalTo(self.view).offset(-77);
//                make.top.equalTo(line1).offset(80);
//                make.height.equalTo(@29);
//    }];
    
    
    iptFrm = [[UIView alloc] init];
    iptFrm.backgroundColor = [UIColor whiteColor];
    iptFrm.layer.masksToBounds = YES;
    iptFrm.layer.cornerRadius = 5.0f;
    [self.view addSubview:iptFrm];
    [iptFrm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.top.equalTo(logo.mas_bottom).offset(20);
        make.height.equalTo(@62);
    }];
    
    _loginName = [[UITextField alloc] init];
    _loginName.placeholder = @"Your Email";
    _loginName.font = [UIFont systemFontOfSize:12];
    _loginName.returnKeyType = UIReturnKeyNext;
    _loginName.delegate = self;
    _loginName.text = @"wufei@oranger1.com";  //to delete...
    [iptFrm addSubview:_loginName];
    [_loginName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(iptFrm);
        make.height.equalTo(@30);
    }];
    
    _loginPass = [[UITextField alloc] init];
    _loginPass.placeholder = @"Your Password";
    _loginPass.font = [UIFont systemFontOfSize:12];
    _loginPass.returnKeyType = UIReturnKeyDone;
    _loginPass.delegate = self;
    _loginPass.text = @"356a192b7913b04c54574d18c28d46e6395428ab";
    [iptFrm addSubview:_loginPass];
    [_loginPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.bottom.equalTo(iptFrm);
        make.height.equalTo(@30);
    }];
    UIView* line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor wbt_colorWithHexValue:0xF9F9FA alpha:1];
    [iptFrm addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.bottom.equalTo(_loginPass.mas_top);
        make.height.equalTo(@2);
    }];
    
    UILabel* lose = [[UILabel alloc] init];
    lose.textAlignment = NSTextAlignmentCenter;
    lose.font = [UIFont systemFontOfSize:13];
    lose.textColor = ORANGE_C;
    lose.userInteractionEnabled = YES;

    UITapGestureRecognizer* tapLose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedLose)];
    [lose addGestureRecognizer:tapLose];
    lose.text = @"Forget your password?";
    [self.view addSubview:lose];
    [lose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(iptFrm.mas_bottom);
    }];
    
    UIView* line3 = [self addLine];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-45);
    }];
    
    //[self registerKeyBoardNotifications];
}

-(void) touchedRight
{
    RegStep1* reg = [[RegStep1 alloc] init];
    [self.navigationController pushViewController:reg animated:YES];
}

-(void) touchedLose
{
    ForgetPassController* ctrl = [[ForgetPassController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
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
    NSString* txt = textField.text;
    if (textField == _loginName) {
        if ([StringUtil nullStr:txt]) {
            [self errorMessage:@"Please input your email"];
            return  NO;
        }
        [_loginPass becomeFirstResponder];
    }else if(textField == _loginPass) {
        if ([StringUtil nullStr:txt]) {
            [self errorMessage:@"Please input your password"];
            return  NO;
        }
        [self commit];
    }
    return YES;
}

-(void) commit
{
    if ([StringUtil nullStr:_loginName.text]) {
        [self errorMessage:@"Please input your email"];
        return;
    }
    if ([StringUtil nullStr:_loginPass.text]) {
        [self errorMessage:@"Please input your password"];
        return;
    }
    
    SuserEngine* engine = [[SuserEngine alloc] init];
    [engine userLogin:_loginName.text Password:_loginPass.text Encrypt:@"y" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            NSArray* arr = (NSArray*) data;
            SuserModel *user = [arr firstObject];
            user.uid = 45; ///to modify ...
            [[SaccountStore sharedInstance] resetCurrentAccount:user];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"KEY_LOGINSTATE_CHANGE" object:@{@"flag":@"login"}];
            NSLog(@"123123 %@",data);
        }else {
            [self requestError:error];
        }
    }];
}

/**
-(void) registerKeyBoardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

///键盘显示
-(void) keyBoardWasShown:(NSNotification*) notify
{
    NSDictionary* info = [notify userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    CGFloat keyHeight = kbSize.height;
    [iptFrm mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-keyHeight);
    }];
}
// will hide
-(void) keyBoardWillHide:(NSNotification*) notify
{
    _scroll.wbtHeight = self.view.wbtHeight;
    [_scroll setContentOffset:CGPointZero];
}
**/
-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loginFb
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"] fromViewController:self
        handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Logged in");
            FBSDKGraphRequest* requestMe = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, gender, first_name, last_name, locale, email,picture"} tokenString:result.token.tokenString version:nil HTTPMethod:nil];
            [requestMe startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id sresult, NSError *error) {
                NSString *actualID = sresult[@"id"];
                NSString* actualName = sresult[@"name"];
                NSDictionary* spicture = sresult[@"picture"];
                NSDictionary* spicData = [spicture objectForKey:@"data"];
                NSString* actualAvatar = [spicData objectForKey:@"url"];
                SuserEngine* engine = [[SuserEngine alloc] init];
                [engine userFacebookLobin:actualID UserName:actualName Avatar:actualAvatar Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
                    if (success) {
                        NSArray* arr = (NSArray*) data;
                        SuserModel *user = [arr firstObject];
                        user.uid = 45;  ///to modify ...
                        [[SaccountStore sharedInstance] resetCurrentAccount:user];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"KEY_LOGINSTATE_CHANGE" object:@{@"flag":@"login"}];
                        NSLog(@"123123 %@",data);
                    }else {
                        [self requestError:error];
                    }
                }];
            }];
        }
    }];
}


@end


