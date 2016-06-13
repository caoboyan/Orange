//
//  CreateDetailController.m
//  Orange
//
//  Created by Aiwa on 4/17/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "CreateDetailController.h"
#import "ImagepickerController.h"

#import "CalendarView.h"

#import "SeventEngine.h"

#import "MapController.h"

@interface CreateDetailController ()<UITableViewDelegate, UITableViewDataSource,
        UITextFieldDelegate, UITextViewDelegate,
        ModelActionSheetSelectedDelegate,
        ImagePickerDelegate,
        calendarSelectedProtocal,
        addrSelectDelegate>
{
    UILabel* _headerMiddleLabel;
    
    UITableView* _tableView;
    
    UIView* _selectorView;
    
    BOOL _selectorShowing;
    
    NSMutableArray* _tableData;
    
    UIImageView* _wall;
    
    UILabel* _time;
    UILabel* _location;
    UILabel* _persons;
    
    UITextView* _eventTitle;
    UITextField* _cost;
    UITextField* _moreInfo;
    
    UISwitch* _askJoin;
    UIImageView* _invite;
    
    NSArray* _selectorData;
    
    ///// datas
    NSInteger Max_num;
    NSString* ADDRESS;
    NSString* STARTDATE;
    NSString* STOPDATE;
    NSString* longitude;
    NSString* latitude;
    NSString* date;
    NSString* imageurl;
    NSString* eventId;
}

@end

@implementation CreateDetailController

@synthesize eventType;

- (void)viewDidLoad {
    [super viewDidLoad];
    Max_num = -1;
    _selectorData = @[@"Music",@"Movie",@"Sports",@"Bar/Club",@"Outdoor",@"Restaurant",@"Party",@"Study",@"Other"];
    _selectorShowing = NO;
    
    [self initViews];
    [self setHeader];
    
    [self initSelector];
    
}

-(void) initViews
{
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = ORANGE_C;
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(@0);
        make.height.equalTo(@1);
    }];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, K_SCREEN_W, K_SCREEN_H-64)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor wbt_colorWithHexValue:0xbfbfbf alpha:1];
}

-(void) setHeader
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
    
    UIView* header_middle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    self.navigationItem.titleView = header_middle;
    
    _headerMiddleLabel = [[UILabel alloc] init];
    _headerMiddleLabel.text = [_selectorData objectAtIndex:self.eventType];
    _headerMiddleLabel.font = [UIFont systemFontOfSize:14];
    _headerMiddleLabel.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    [header_middle addSubview:_headerMiddleLabel];
    [_headerMiddleLabel sizeToFit];
    
    [_headerMiddleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(header_middle);
    }];
    UITapGestureRecognizer* tapHeaderMiddle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedHeaderMiddle)];
    header_middle.userInteractionEnabled = YES;
    [header_middle addGestureRecognizer:tapHeaderMiddle];
    UIImageView* arr = [[UIImageView alloc] init];
    arr.backgroundColor = [UIColor orangeColor];
    [header_middle addSubview:arr];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerMiddleLabel.mas_right).offset(5);
        make.centerY.equalTo(header_middle);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UIButton* sb = [UIButton buttonWithType:UIButtonTypeCustom];
    sb.frame = CGRectMake(0, 0, 120, 44);
    sb.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [sb setTitle:@"Create" forState:UIControlStateNormal];
    sb.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    sb.titleLabel.textAlignment = NSTextAlignmentRight;
    [sb setTitleColor:ORANGE_C forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sb];
    [sb addTarget:self action:@selector(touchedCreate) forControlEvents:UIControlEventTouchUpInside];
}

-(void) initSelector
{
    _selectorView = [[UIView alloc] init];
    _selectorView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_selectorView];
    [_selectorView setHidden:YES];
    [_selectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@1);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, K_SCREEN_H-64-1));
    }];
    
    UIScrollView* sv = [[UIScrollView alloc] init];
    //    sv.backgroundColor = [UIColor grayColor];
    [_selectorView addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectorView).offset(0);
        make.right.equalTo(_selectorView).offset(0);
        make.top.equalTo(@1);
        make.height.equalTo(@(K_SCREEN_H-114));
    }];
    CGFloat st = 0;
    for (int i=0; i<[_selectorData count]; i++) {
        UILabel* sl = [[UILabel alloc] initWithFrame:CGRectMake(0, st, K_SCREEN_W, 65)];
        sl.tag = 1987 + i;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedSelector:)];
        sl.userInteractionEnabled = YES;
        [sl addGestureRecognizer:tap];
        sl.textAlignment = NSTextAlignmentCenter;
        sl.font = [UIFont systemFontOfSize:16];
        sl.textColor = [UIColor wbt_colorWithHexValue:0xbbbbbb alpha:1];
        sl.text = [_selectorData objectAtIndex:i];
        [sv addSubview:sl];
        UIView* sline = [[UIView alloc] initWithFrame:CGRectMake(0, st+65, K_SCREEN_W, 1)];
        sline.backgroundColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1];
        [sv addSubview:sline];
        st += 66;
    }
    sv.contentSize = CGSizeMake(K_SCREEN_W, st);
}

-(void) touchedSelector:(UITapGestureRecognizer*) gesture
{
    NSInteger tag = gesture.view.tag - 1987;
    NSString* stxt = [_selectorData objectAtIndex:tag];
    _headerMiddleLabel.text = stxt;
    [_headerMiddleLabel sizeToFit];
    _selectorShowing = NO;
    [_selectorView setHidden:YES];
}

-(void) touchedHeaderMiddle
{
    if (_selectorShowing == NO) {
        _selectorShowing = YES;
        [_selectorView setHidden:NO];
    }else {
        _selectorShowing =  NO;
        [_selectorView setHidden:YES];
    }
}

#pragma mark ==== delegate of table
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 3;
    return 2;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1) {
        return 5;
    }else {
        return 2;
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }
    return 44;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        return 8;
    }
    return 0.1;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    if (section == 0) {
        _wall = [[UIImageView alloc] init];
        _wall.image = [UIImage imageNamed:@"orange_logo"];
        [cell.contentView addSubview:_wall];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedWall)];
        _wall.userInteractionEnabled = YES;
        [_wall addGestureRecognizer:tap];
        /// set image ...
        [_wall mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.centerY.equalTo(cell.contentView);
            make.size.mas_equalTo(CGSizeMake(88, 55));
        }];
        _eventTitle = [[UITextView alloc] init];
        _eventTitle.text = @"Topic";
        _eventTitle.font = [UIFont systemFontOfSize:15];
        _eventTitle.returnKeyType = UIReturnKeyDone;
        _eventTitle.delegate = self;
        _eventTitle.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
        [cell.contentView addSubview:_eventTitle];
        [_eventTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_wall.mas_right).offset(5);
            make.right.equalTo(cell.contentView).offset(-15);
            make.height.equalTo(@40);
            make.top.equalTo(@9);
        }];
        UILabel* sl = [[UILabel alloc] init];
        sl.text = @"(up to 70 characters)";
        sl.font = [UIFont systemFontOfSize:10];
        sl.textColor = [UIColor wbt_colorWithHexValue:0xbfbfbf alpha:1];
        [cell.contentView addSubview:sl];
        [sl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_eventTitle).offset(5);
            make.right.equalTo(_eventTitle).offset(-15);
            make.height.equalTo(@12);
            make.top.equalTo(_eventTitle.mas_bottom).offset(0);
        }];
        return cell;
    }else if(section == 1){
        // ////////////////////////////////////////////////////////////////////////////////////
        UIImageView* sv;
        if (row < 4) {
            NSArray* simgs = @[@"create_detail_time",@"create_detail_location",@"create_detail_persons",@"create_detail_cost"]; /////////
            sv = [[UIImageView alloc] init];
            if (![StringUtil nullStr:[simgs objectAtIndex:row]]) {
                sv.image = [UIImage imageNamed:[simgs objectAtIndex:row]];
            }
            [cell.contentView addSubview:sv];
            [sv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@20);
                make.centerY.equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(34, 34));
            }];
        }
        if (row == 0) {
            _time = [[UILabel alloc] init];
            _time.font = [UIFont systemFontOfSize:10];
            _time.text = @"Time and date";
            _time.textColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1];
            [cell.contentView addSubview:_time];
            [_time mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-25);
                make.left.equalTo(sv.mas_right).offset(5);
                make.height.equalTo(@12);
                make.centerY.equalTo(cell.contentView);
            }];
        }else if (row == 1) {
            _location = [[UILabel alloc] init];
            _location.text = @"Events Address";
            _location.font = [UIFont systemFontOfSize:10];
            _location.textColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1];
            [cell.contentView addSubview:_location];
            [_location mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-25);
                make.left.equalTo(sv.mas_right).offset(5);
                make.height.equalTo(@12);
                make.centerY.equalTo(cell.contentView);
            }];
        }else if (row == 2) {
            _persons = [[UILabel alloc] init];
            _persons.text = @"Event Persons";
            _persons.font = [UIFont systemFontOfSize:10];
            _persons.textColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1];
            [cell.contentView addSubview:_persons];
            [_persons mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-25);
                make.left.equalTo(sv.mas_right).offset(5);
                make.height.equalTo(@12);
                make.centerY.equalTo(cell.contentView);
            }];
        }else if (row == 3) {
            _cost = [[UITextField alloc] init];
            _cost.placeholder = @"Event Cost";
            _cost.font = [UIFont systemFontOfSize:10];
            _cost.textColor = [UIColor wbt_colorWithHexValue:0x333333 alpha:1];
            _cost.returnKeyType = UIReturnKeyDone;
            _cost.delegate = self;
            [cell.contentView addSubview:_cost];
            [_cost mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-25);
                make.left.equalTo(sv.mas_right).offset(5);
                make.height.equalTo(@12);
                make.centerY.equalTo(cell.contentView);
            }];
        }else {
            _moreInfo = [[UITextField alloc] init];
            _moreInfo.placeholder = @"Add more info...";
            _moreInfo.font = [UIFont systemFontOfSize:10];
            _moreInfo.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
            _moreInfo.returnKeyType = UIReturnKeyDone;
            _moreInfo.delegate = self;
            [cell.contentView addSubview:_moreInfo];
            [_moreInfo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-25);
                make.left.equalTo(cell.contentView).offset(22);
                make.height.equalTo(@12);
                make.centerY.equalTo(cell.contentView);
            }];
        }
    }else { //section === 2  ////这部分暂时不搞，接口不涉及  /////////////////
        NSArray* stxt = @[@"Ask request to join",@"Invite firends"];
        UILabel* sl = [[UILabel alloc] init];
        sl.text = [stxt objectAtIndex:row];
        [cell.contentView addSubview:sl];
        sl.font = [UIFont systemFontOfSize:10];
        sl.textColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1];
        [sl sizeToFit];
        [sl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(22);
            make.centerY.equalTo(cell.contentView);
        }];
        if (row == 0) {
            _askJoin = [[UISwitch alloc] init];
            [cell.contentView addSubview:_askJoin];
            [_askJoin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-15);
                make.centerY.equalTo(cell.contentView);
            }];
        }else {
            _invite = [[UIImageView alloc] init];
            _invite.backgroundColor = [UIColor orangeColor];
            [cell.contentView addSubview:_invite];
            [_invite mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.contentView).offset(-15);
                make.centerY.equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(25, 25));
            }];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 1) {
        if (row == 0) {
            CGFloat ah = [CalendarView viewHeight];
            CalendarView* view = [[CalendarView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height-ah)/2, K_SCREEN_W, ah)];
            view.backgroundColor = [UIColor greenColor];
            view.delegate = self;
            [self.view addSubview:view];
        }else if(row == 1) {
            MapController* map = [[MapController alloc] init];
            map.delegate = self;
            [self presentViewController:map animated:YES completion:nil];
        }else if(row == 2) {
            NSArray* arr = @[@"unlimit",@"5",@"10",@"20",@"50"];
            ModelActionSheet* sheet = [[ModelActionSheet alloc] initWithFrame:CGRectZero tableTitle:@"" Strings:arr ICons:nil Colors:nil Identify:0];
            sheet.delegate = self;
        }
    }
}

////////// submit
-(void) touchedCreate
{
    if (![StringUtil nullStr:eventId]) {
        [self addImage2Event];
        return;
    }
    if (Max_num == -1
        || [StringUtil nullStr:ADDRESS]
        || [StringUtil nullStr:STARTDATE]
        || [StringUtil nullStr:_persons.text]
        || [StringUtil nullStr:_cost.text]
        || [StringUtil nullStr:imageurl]
        || [StringUtil nullStr:_moreInfo.text]
        || [StringUtil nullStr:_eventTitle.text]) {
        [self errorMessage:@"Please fill all contents"];
        return;
    }
    NSArray* txts = @[@"Music",@"Movie",@"Sports",@"Bar/Club",@"Outdoor",@"Restaurant",@"Party",@"Study",@"More"];
    NSString* currentUid = [[SaccountStore sharedInstance] getCurrentUid];
    
    
    SeventEngine* engine = [[SeventEngine alloc] init];
    [engine addNewEvent:[txts objectAtIndex:self.eventType]
                 Stopic:_eventTitle.text
               Scontent:_moreInfo.text
               Smax_num:Max_num
                 Scosts:_cost.text
               Saddress:ADDRESS
             Sstartdate:STARTDATE
              Sstopdate:STOPDATE
             Slongitude:longitude
              Slatitude:latitude
             Sowner_uid:[currentUid integerValue]
           SCurrent_num:1
                 Sstate:0
                  Sdate:date
                Encrypt:@"N" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            [self alertMessageWithHandler:@"Create Success" OK:^{
                //先不跳转，先加上图片 todo ...
                eventId = @"123123123";
                [self addImage2Event];
            }];
        }else {
            [self requestError:error];
        }
    }];
}

-(void) addImage2Event
{
    SimageEngine* engine = [[SimageEngine alloc] init];
    [engine addPictureUrl:imageurl NewsId:@"" PictureUrl:imageurl EventId:eventId Kind:@"1" Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [self requestError:error];
        }
    }];
}

-(void) touchedWall
{
    NSArray* arr = @[@"拍照",@"从手机相册选择"];
    ModelActionSheet* sheet = [[ModelActionSheet alloc] initWithFrame:CGRectZero tableTitle:@"选择上课方式" Strings:arr ICons:nil Colors:nil Identify:1];
    sheet.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

-(void) sheetSelected:(NSInteger)row {}
-(void) sheetSelected:(NSInteger) row Identify:(NSInteger) identify
{
    if (identify == 0) { ///人数
        NSArray* arr = @[@"0",@"5",@"10",@"20",@"50"];
        Max_num = [[arr objectAtIndex:row] integerValue];
        _persons.text = [NSString stringWithFormat:@"%ld",Max_num];
        _persons.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    }else if (identify == 1) {
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
    /**  ContentTypes = "<null>";
     CreatedTimestamp = "2016-05-10T17:50:56.0399901Z";
     Description = "<null>";
     DownloadLink = "TODO, will implement when file is persisited";
     FileNames =     (
     "D:\\WWWROOT\\WebAPI\\upload\\BodyPart_3d14c964-905d-422d-97a3-c1eadb51abb8.png"
     );
     Names =     (
     "\"file.png\""
     );
     UpdatedTimestamp = "2016-05-10T17:50:56.0399901Z";
     ***/
    _wall.image = image;
    SimageEngine* engine  = [[SimageEngine alloc] init];
    [engine uploadImage:image ExtraParams:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            ////
            NSDictionary* sdict = (NSDictionary*) data;
            NSString* imgPath = [(NSArray*)[sdict objectForKey:@"FileNames"] firstObject] ;
            imageurl = [StringUtil imageNameSplit:imgPath];
        }else {
            [self requestError:error];
        }
    }];
}

#pragma mark ==== delegate for time selector :
-(void) selectedDate:(NSDate*) startDate EndDate:(NSDate*) endDate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"]; //yyyy-MM-dd HH:mm:ss
    STARTDATE = [formatter stringFromDate:startDate];
    STOPDATE = [formatter stringFromDate:endDate];
    date = [formatter stringFromDate:[NSDate date]];
    _time.text = [NSString stringWithFormat:@"%@ ~~ %@", STARTDATE, STOPDATE];
    _time.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
}

#pragma mark ==== map delegate..
/**  city = London;
 latitude = "51.5014014";
 longitude = "-0.125002";
 name = "Big Ben";
 street = "";  **/
-(void) didAddrSelected:(NSDictionary*) addr
{
    _location.text = [addr objectForKey:@"name"];
    _location.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    ADDRESS = [NSString stringWithFormat:@"%@%@", [addr objectForKey:@"name"], [addr objectForKey:@"street"]];
    latitude = [addr objectForKey:@"latitude"];
    longitude = [addr objectForKey:@"longitude"];
}



@end
