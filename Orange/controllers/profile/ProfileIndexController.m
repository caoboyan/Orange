//
//  ProfileIndexController.m
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "ProfileIndexController.h"
#import "SuserEngine.h"
#import "ImagepickerController.h"

#import "MyEventsController.h"
#import "MySettingsController.h"

#import "SimageEngine.h"

@interface profileCell : UITableViewCell
{
    UIImageView* logo;
    UILabel* txtLabel;
    UILabel* countLabel;
}
-(void) cellContent:(NSString*) img Txt:(NSString*) txt Count:(NSString*) scount;
@end

@implementation profileCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void) initViews
{
    logo = [[UIImageView alloc] init];
    [self.contentView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    countLabel = [[UILabel alloc] init];
    [countLabel setHidden: YES];
    countLabel.backgroundColor = ORANGE_C;
    countLabel.font = [UIFont systemFontOfSize:10];
    countLabel.layer.masksToBounds = YES;
    countLabel.layer.cornerRadius = 3.0f;
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-25);
        make.size.mas_equalTo(CGSizeMake(25, 15));
        make.centerY.equalTo(self.contentView);
    }];
    
    txtLabel = [[UILabel alloc] init];
    txtLabel.font = [UIFont systemFontOfSize:12];
    txtLabel.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    [self.contentView addSubview:txtLabel];
    [txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logo.mas_right).offset(15);
        make.right.equalTo(countLabel.mas_left).offset(-15);
        make.height.equalTo(@15);
        make.centerY.equalTo(self.contentView);
    }];
    UIView* line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = [UIColor wbt_colorWithHexValue:0xeeeeee alpha:1];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W-10, 0.5));
    }];
}

-(void) cellContent:(NSString*) img Txt:(NSString*) txt Count:(NSString*) scount
{
    logo.image = [UIImage imageNamed:img];
    txtLabel.text = txt;
    if ([StringUtil nullStr:scount]) {
        [countLabel setHidden:YES];
    }else {
        [countLabel setHidden:NO];
        countLabel.text  = scount;
    }
}

@end

///////////////////////////////////////////////////////////////////////////

@interface ProfileIndexController ()<UITableViewDelegate, UITableViewDataSource,ModelActionSheetSelectedDelegate,ImagePickerDelegate>
{
    UITableView* _tableView;
    
    UIImageView* _wall;
    UIImageView* _avatarImage;
    UILabel* _name;
    UILabel* _sex;
    
    SuserModel* _currentUser;
    
    NSArray* _iconArr;
    NSArray* _txtArr;
    NSArray* _countArr;
}

@end

@implementation ProfileIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    _iconArr = @[@"p_evt_coming",@"p_evt_coming",@"p_evt_past",@"p_evt_liked",@"p_rate_app",@"p_settings"];
    _txtArr = @[@"Created Events",@"Up Coming Events",@"Past Events",@"Liked Events",@"Rate the app",@"Settings"];
    _countArr = @[@"",@"",@"",@"",@"",@""];
    [self setTitleText:@"profile"];
    [self initViews];
}

-(void) initViews
{
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
    
    _avatarImage = [[UIImageView alloc] init];
    _avatarImage.backgroundColor = [UIColor orangeColor];
    _avatarImage.layer.masksToBounds = YES;
    _avatarImage.layer.cornerRadius = 37;
    [ava_frm addSubview:_avatarImage];
    _avatarImage.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedAvatar)];
    [_avatarImage addGestureRecognizer:tap];
    [_avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wall.mas_bottom);
        make.bottom.equalTo(self.view);
        make.left.equalTo(@0);
        make.width.equalTo(@(K_SCREEN_W));
    }];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    profileCell* cell = [tableView dequeueReusableCellWithIdentifier:@"xxxx"];
    if (cell == nil) {
        cell = [[profileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xxxx"];
    }
    [cell cellContent:[_iconArr objectAtIndex:indexPath.row] Txt:[_txtArr objectAtIndex:indexPath.row] Count:[_countArr objectAtIndex:indexPath.row]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row < 4) {
        MyEventsController* ctrl = [[MyEventsController alloc] init];
        ctrl.eventType = indexPath.row;
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    }else if(indexPath.row == 4) { //rate the app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    }else if(indexPath.row == 5) { //settings
        MySettingsController* ctrl = [[MySettingsController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _currentUser = [[SaccountStore sharedInstance] getCurrentAccount];
    [self fillUser];
}

-(void) fillUser
{
    _name.text = _currentUser.uname;
    _sex.text = _currentUser.sex;
}

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
    _avatarImage.image = image;
    SimageEngine* engine = [[SimageEngine alloc] init];
    [engine uploadImage:image ExtraParams:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if(success) {
            NSArray* imgArr = [(NSDictionary*) data objectForKey:@"FileNames"];
            NSString* picture = [StringUtil imageNameSplit:(NSString*)[imgArr firstObject]];
            [self updateImage:picture];
        }else {
            
        }
    }];
}

-(void) updateImage:(NSString*) image
{
    SuserModel* currentUser = [[SaccountStore sharedInstance] getCurrentAccount];
    SuserEngine* engine = [[SuserEngine alloc] init];
    NSDictionary* dict = @{@"Picture":image};
    [engine userUpdateByEmail:currentUser.email Encrypt:@"n" Extra:dict completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            currentUser.Picture = image;
            [[SaccountStore sharedInstance] resetCurrentAccount:currentUser];
        }else {
            [self requestError:error];
        }
    }];
}



@end
