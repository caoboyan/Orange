//
//  OtherProfileViewController.m
//  Orange
//
//  Created by Aiwa on 4/13/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "OtherProfileViewController.h"

@interface OtherProfileViewController ()
{
    UIImageView* _wall;
    UIImageView* _avatar;
    UILabel* _name;
    UILabel* _sex;
}
@end

@implementation OtherProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Profile"];
    [self initViews];
}

-(void) initViews
{
    UILabel* back = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    back.textAlignment = NSTextAlignmentLeft;
    back.font = [UIFont boldSystemFontOfSize:14];
    back.textColor = ORANGE_C;
    back.text = @"Back";
    back.userInteractionEnabled = YES;
    UITapGestureRecognizer* tapBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myGoBack)];
    [back addGestureRecognizer:tapBack];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    CGFloat imgh = 300 * K_SCREEN_W / 750;
    _wall = [[UIImageView alloc] init];
    _wall.backgroundColor = ORANGE_C;
    [self.view addSubview:_wall];
    [_wall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, imgh));
    }];
    
    UIView* ava_frm = [[UIView alloc] init];
    ava_frm.backgroundColor = [UIColor whiteColor];
    ava_frm.layer.masksToBounds = YES;
    ava_frm.layer.cornerRadius = 38;
    [self.view addSubview:ava_frm];
    [ava_frm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_wall);
        make.centerY.equalTo(_wall).offset(-10);
        make.size.mas_equalTo(CGSizeMake(77, 77));
    }];
    
    _avatar = [[UIImageView alloc] init];
    _avatar.backgroundColor = [UIColor orangeColor];
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = 37;
    [ava_frm addSubview:_avatar];
    [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ava_frm);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    
    _name = [[UILabel alloc] init];
    _name.font = [UIFont systemFontOfSize:12];
    _name.textColor = [UIColor whiteColor];
    _name.text = @"name ....";
    [_name sizeToFit];
    [self.view addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(ava_frm.mas_bottom).offset(5);
    }];
    
    _sex = [[UILabel alloc] init];
    _sex.font = [UIFont systemFontOfSize:10];
    _sex.textColor = [UIColor whiteColor];
    _sex.text = @"sex ....";
    [_sex sizeToFit];
    [self.view addSubview:_sex];
    [_sex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_name.mas_bottom).offset(2);
    }];
    ///fav
    UIView* favView = [[UIView alloc] init];
    [self.view addSubview:favView];
    [favView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wall.mas_bottom);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 90));
    }];
    CGFloat sleft = 37;
    for (int i=0; i<3; i++) {
        UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(sleft, 15, 47, 47)];
        img.backgroundColor = [UIColor orangeColor];
        [favView addSubview:img];
        UILabel* sl =[[UILabel alloc] initWithFrame:CGRectMake(sleft, 65, 47, 15)];
        sl.textAlignment = NSTextAlignmentCenter;
        sl.font = [UIFont systemFontOfSize:12];
        sl.textColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1];
        sl.text = @"Sprots";
        [favView addSubview:sl];
        sleft += 19+47;
    }
    
    UIButton* sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.backgroundColor = ORANGE_C;
    [sendBtn setTitle:@"Send Friend Request" forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [sendBtn addTarget:self action:@selector(touchedSend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(favView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 30));
    }];
}

-(void) touchedSend
{
    
}



@end
