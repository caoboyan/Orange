//
//  RegStep2.m
//  Orange
//
//  Created by Aiwa on 3/28/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "RegStep2.h"
#import "RegStep3.h"
#import "SimageEngine.h"
#import "ImagepickerController.h"


@interface RegStep2 () <UITextFieldDelegate,ModelActionSheetSelectedDelegate,ImagePickerDelegate>
{
    UITextField* _fitstName;
    UITextField* _lastName;
    
    UIImageView* _avatarImage;
    
    NSString* imageString;
    
}

@end

@implementation RegStep2
@synthesize email, mobile;

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
    txt.text = @"What's Your Name?";
    [self.view addSubview:txt];
    [txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(@90);
        make.height.equalTo(@14);
    }];
    
    CGFloat sw = (K_SCREEN_W - 32 - 26) /2 ;
    
    _fitstName = [[UITextField alloc] init];
    _fitstName.font = [UIFont systemFontOfSize:12];
    _fitstName.returnKeyType = UIReturnKeyNext;
    _fitstName.placeholder = @"First Name";
    _fitstName.layer.masksToBounds = YES;
    _fitstName.layer.cornerRadius = 5.0f;
    _fitstName.backgroundColor = [UIColor whiteColor];
    _fitstName.delegate = self;
    UIView* left1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    _fitstName.leftView = left1;
    _fitstName.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_fitstName];
    [_fitstName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.width.equalTo(@(sw));
        make.top.equalTo(txt.mas_bottom).offset(8);
        make.height.equalTo(@30);
    }];
    
    _lastName = [[UITextField alloc] init];
    _lastName.font = [UIFont systemFontOfSize:12];
    _lastName.returnKeyType = UIReturnKeyDone;
    _lastName.placeholder = @"Sunname";
    _lastName.layer.masksToBounds = YES;
    _lastName.layer.cornerRadius = 5.0f;
    _lastName.backgroundColor = [UIColor whiteColor];
    UIView* left2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 30)];
    _lastName.leftView = left2;
    _lastName.leftViewMode = UITextFieldViewModeAlways;
    _lastName.delegate = self;
    [self.view addSubview:_lastName];
    [_lastName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
        make.width.equalTo(@(sw));
        make.top.equalTo(txt.mas_bottom).offset(8);
        make.height.equalTo(@30);
    }];
    
    
    UILabel* txt2 = [[UILabel alloc] init];
    txt2.font = [UIFont systemFontOfSize:14];
    txt2.textColor = ORANGE_C;
    txt2.userInteractionEnabled = YES;
    txt2.text = @"Your Avatar";
    [self.view addSubview:txt2];
    [txt2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(33);
        make.right.equalTo(self.view).offset(-33);
        make.top.equalTo(_lastName.mas_bottom).offset(20);
        make.height.equalTo(@14);
    }];
    
    
    _avatarImage = [[UIImageView alloc] init];
    _avatarImage.backgroundColor = [UIColor orangeColor];
    _avatarImage.layer.masksToBounds = YES;
    _avatarImage.layer.cornerRadius = 37;
    [self.view addSubview:_avatarImage];
    _avatarImage.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedAvatar)];
    [_avatarImage addGestureRecognizer:tap];
    [_avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(txt2.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(75, 75));
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
//    [_email resignFirstResponder];
    return YES;
}

-(void) commit
{
    NSString* firstName = _fitstName.text;
    NSString* lastName = _lastName.text;
    
    if ([StringUtil nullStr:firstName] || [StringUtil nullStr:lastName]) {
        [self alertError:@"Please insert correct name"];
        return;
    }
    if ([StringUtil nullStr:imageString]) {
        [self alertError:@"Please choice your avatar image"];
        return;
    }
    RegStep3* ctrl = [[RegStep3 alloc] init];
    ctrl.email = self.email;
    ctrl.mobile = self.mobile;
    ctrl.firstName = firstName;
    ctrl.sunName = lastName;
    ctrl.picture = imageString;
    [self.navigationController pushViewController:ctrl animated:YES];
}
//////
//////// avatar 相关
-(void) touchedAvatar
{
    NSArray* arr = @[@"拍照",@"从手机相册选择"];
    ModelActionSheet* sheet = [[ModelActionSheet alloc] initWithFrame:CGRectZero tableTitle:@"选择上课方式" Strings:arr ICons:nil Colors:nil Identify:0];
    sheet.delegate = self;
}
-(void) sheetSelected:(NSInteger)row {}

-(void) sheetSelected:(NSInteger)row Identify:(NSInteger)identify
{
    if (identify == 0) {
        ImagepickerController* ctrl = [[ImagepickerController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        ctrl.isCamera = NO;
        ctrl.delegate = self;
        ctrl.isCamera = row != 1;
        [self.navigationController pushViewController:ctrl animated:NO];
    }
}

-(void) imagePicked:(UIImage*) image
{
    SimageEngine* engine = [[SimageEngine alloc] init];
    [engine uploadImage:image ExtraParams:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            _avatarImage.image = image;
            NSDictionary* dict = (NSDictionary*) data;
            NSArray* images = [dict objectForKey:@"FileNames"];
            if ([images count] >0) {
                NSString* simgName = [images objectAtIndex:0];
                imageString = [StringUtil imageNameSplit:simgName];
            }
        }
    }];
}

@end
