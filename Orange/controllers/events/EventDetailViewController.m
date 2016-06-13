//
//  EventDetailViewController.m
//  Orange
//
//  Created by Aiwa on 3/29/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "EventDetailViewController.h"
#import "SeventEngine.h"
#import "EventCommentCell.h"
#import "SeventCommentModel.h"
#import "SaccountStore.h"

@interface EventDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView* _frameView;
    UIImageView* _heart;
    
    UIScrollView* _partners;
    UIButton* _joinBtn;
    UITextField* _addComment;
    
}

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataList;

@end

@implementation EventDetailViewController
@synthesize eventModel;

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc]init];
    }
    return _dataList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Detail"];
    [self initNav];
    [self customTableView];
    [self initViews];
    [self getNearbyData];
}

- (void)customTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[EventCommentCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshCommentHeader)];
    self.tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshCommentFooter)];
    [self.view addSubview:self.tableView];
}

-(void) initNav
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
}

-(void) initViews
{
    _frameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, 340)];
    _frameView.backgroundColor = [UIColor wbt_colorWithHexValue:0xeeeeee alpha:1];
    
    //headers:
    CGFloat imgH = 300 * K_SCREEN_W / 750;
    UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, imgH)];
    img.backgroundColor = [UIColor orangeColor];
    NSString* surl = [NSString stringWithFormat:@"%@%@",IMAGE_PREFIX,self.eventModel.picture];
    [img sd_setImageWithURL:[NSURL URLWithString:surl] placeholderImage:IMAGE_PLACE];
    [_frameView addSubview:img];
    
    UIView* mask = [[UIView alloc] init];
    mask.backgroundColor = [UIColor blackColor];
    mask.layer.opacity = 0.4;
    [_frameView addSubview:mask];
    [mask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 50));
        make.left.equalTo(@0);
        make.bottom.equalTo(img);
    }];
    
    UIImageView* heart = [[UIImageView alloc] init];
    heart.backgroundColor  =[UIColor greenColor];
    [_frameView addSubview:heart];
    [heart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(img).offset(-15);
        make.centerY.equalTo(mask);
    }];
    
    UILabel* stitle = [[UILabel alloc] init];
    stitle.textColor = [UIColor whiteColor];
    stitle.text = self.eventModel.Topic;
    stitle.font = [UIFont boldSystemFontOfSize:15];
    stitle.numberOfLines = 0;
    [_frameView addSubview:stitle];
    [stitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(heart.mas_left).offset(-10);
        make.centerY.equalTo(mask);
        make.height.equalTo(@50);
    }];
    
    NSString* stxt = self.eventModel.Content;
    CGFloat sh = [StringUtil getTextHeight:stxt forFont:[UIFont systemFontOfSize:12] andWidth:K_SCREEN_W-30];
    // 描述 + 参与用户
    UIView* deskFrm = [[UIView alloc] init];
    deskFrm.backgroundColor = [UIColor wbt_colorWithHexValue:0xcccccc alpha:1];
    [_frameView addSubview:deskFrm];
    [deskFrm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, sh+35));
        make.left.equalTo(@0);
        make.top.equalTo(img.mas_bottom);
    }];
    UILabel* deslLabel = [[UILabel alloc] init];
    deslLabel.text = stxt;
    deslLabel.numberOfLines = 0;
    deslLabel.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    deslLabel.font = [UIFont systemFontOfSize:12];
    [deskFrm addSubview:deslLabel];
    [deslLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W-30, sh));
        make.centerX.equalTo(deskFrm);
        make.top.equalTo(@0);
    }];
    
    _partners = [[UIScrollView alloc] init];
    /// todo..
    [deskFrm addSubview:_partners];
    [_partners mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deskFrm).offset(10);
        make.right.equalTo(deskFrm).offset(-10);
        make.left.equalTo(@10);
        make.height.equalTo(@25);
    }];
    
    //////// 4 lines ... //////////////
    UIView* timeline = [[UIView alloc] init];
    timeline.backgroundColor = [UIColor whiteColor];
    [_frameView addSubview:timeline];
    [timeline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(deskFrm.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 20));
    }];
    UIImageView* img_time = [[UIImageView alloc] init];
    img_time.backgroundColor = [UIColor orangeColor];
    [timeline addSubview:img_time];
    [img_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@23);
        make.centerY.equalTo(timeline);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    UIImageView* img_time_sel = [[UIImageView alloc] init];
    UITapGestureRecognizer* tapTime = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedTime)];
    img_time_sel.userInteractionEnabled = YES;
    [img_time_sel addGestureRecognizer:tapTime];
    img_time_sel.backgroundColor = [UIColor orangeColor];
    [timeline addSubview:img_time_sel];
    [img_time_sel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(timeline).offset(-15);
        make.centerY.equalTo(timeline);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    UILabel* timeLabel = [[UILabel alloc] init];
    timeLabel.text = self.eventModel.date;
    timeLabel.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:12];
    [timeline addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img_time.mas_right).offset(10);
        make.right.equalTo(img_time_sel.mas_left).offset(-10);
        make.centerY.equalTo(timeline);
        make.height.equalTo(@15);
    }];
    ///line 2..
    UIView* mapLine = [[UIView alloc] init];
    mapLine.backgroundColor = [UIColor whiteColor];
    [_frameView addSubview:mapLine];
    [mapLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(timeline.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 20));
    }];
    UIImageView* img_map = [[UIImageView alloc] init];
    img_map.backgroundColor = [UIColor orangeColor];
    [mapLine addSubview:img_map];
    [img_map mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@23);
        make.centerY.equalTo(mapLine);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    UIImageView* img_map_sel = [[UIImageView alloc] init];
    UITapGestureRecognizer* tapMap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedMap)];
    img_map_sel.userInteractionEnabled = YES;
    [img_map_sel addGestureRecognizer:tapMap];
    img_map_sel.backgroundColor = [UIColor orangeColor];
    [mapLine addSubview:img_map_sel];
    [img_map_sel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mapLine).offset(-15);
        make.centerY.equalTo(mapLine);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    UILabel* mapLabel = [[UILabel alloc] init];
    mapLabel.text = self.eventModel.ADDRESS;
    mapLabel.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    mapLabel.font = [UIFont systemFontOfSize:12];
    [mapLine addSubview:mapLabel];
    [mapLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img_map.mas_right).offset(10);
        make.right.equalTo(img_map_sel.mas_left).offset(-10);
        make.centerY.equalTo(mapLine);
        make.height.equalTo(@15);
    }];
    //line 3
    UIView* useLine = [[UIView alloc] init];
    useLine.backgroundColor = [UIColor whiteColor];
    [_frameView addSubview:useLine];
    [useLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(mapLine.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 20));
    }];
    UIImageView* img_user = [[UIImageView alloc] init];
    img_user.backgroundColor = [UIColor orangeColor];
    [useLine addSubview:img_user];
    [img_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@23);
        make.centerY.equalTo(useLine);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    UILabel* userLabel = [[UILabel alloc] init];
    NSString* memberCountStr = [NSString stringWithFormat:@"%ld/%ld",self.eventModel.Current_num, self.eventModel.Max_num];
    userLabel.text = memberCountStr;
    userLabel.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    userLabel.font = [UIFont systemFontOfSize:12];
    [useLine addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img_user.mas_right).offset(10);
        make.right.equalTo(useLine).offset(-10);
        make.centerY.equalTo(useLine);
        make.height.equalTo(@15);
    }];
    //line 4
    UIView* coseLine = [[UIView alloc] init];
    coseLine.backgroundColor = [UIColor whiteColor];
    [_frameView addSubview:coseLine];
    [coseLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(useLine.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 20));
    }];
    UIImageView* img_cost = [[UIImageView alloc] init];
    img_cost.backgroundColor = [UIColor orangeColor];
    [coseLine addSubview:img_cost];
    [img_cost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@23);
        make.centerY.equalTo(coseLine);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    UILabel* costLabel = [[UILabel alloc] init];
    costLabel.text = [NSString stringWithFormat:@"$%@",self.eventModel.COSTS];
    costLabel.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    costLabel.font = [UIFont systemFontOfSize:12];
    [coseLine addSubview:costLabel];
    [costLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img_cost.mas_right).offset(10);
        make.right.equalTo(coseLine).offset(-10);
        make.centerY.equalTo(coseLine);
        make.height.equalTo(@15);
    }];
    ///////// join btn
    _joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _joinBtn.backgroundColor = ORANGE_C;
    [_joinBtn setTitle:@"Join" forState:UIControlStateNormal];
    _joinBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_joinBtn addTarget:self action:@selector(touchedJoin) forControlEvents:UIControlEventTouchUpInside];
    [_frameView addSubview:_joinBtn];
    [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(coseLine.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 30));
    }];
    
    //// comments view ..
    UIView* addcommentsView = [[UIView alloc] init];
    [_frameView addSubview:addcommentsView];
    [addcommentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_joinBtn.mas_bottom).offset(6);
        make.left.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 32));
    }];
    UIImageView* ava_add_comments = [[UIImageView alloc] init];
    ava_add_comments.layer.masksToBounds = YES;
    ava_add_comments.layer.cornerRadius = 13;
    ava_add_comments.backgroundColor = [UIColor orangeColor];
    [addcommentsView addSubview:ava_add_comments];
    [ava_add_comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.centerY.equalTo(addcommentsView);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    UITextField* txt_add_comments = [[UITextField alloc] init];
    txt_add_comments.placeholder = @"Add comments";
    txt_add_comments.delegate = self;
    txt_add_comments.returnKeyType = UIReturnKeySend;
    txt_add_comments.font = [UIFont systemFontOfSize:12];
    txt_add_comments.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    [addcommentsView addSubview:txt_add_comments];
    [txt_add_comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ava_add_comments.mas_right).offset(10);
        make.right.equalTo(addcommentsView).offset(-10);
        make.centerY.equalTo(addcommentsView);
        make.height.equalTo(@15);
    }];
    
    self.tableView.tableHeaderView = _frameView;
    
    
//    //// comments ..
//    UIView* commentsView = [[UIView alloc] init];
//    commentsView.backgroundColor = [UIColor greenColor];
//    [_frameView addSubview:commentsView];
//    [commentsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(addcommentsView.mas_bottom).offset(6);
//        make.left.equalTo(@0);
//        make.width.equalTo(@(K_SCREEN_W));
//    }];
//    UILabel* cmt_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, 15)];
//    cmt_title.textColor = [UIColor wbt_colorWithHexValue:0x444444 alpha:1];
//    cmt_title.text = @"Comments(20)";
//    cmt_title.font = [UIFont systemFontOfSize:12];
//    [commentsView addSubview:cmt_title];
//    CGFloat stt = 15;
//    for (int i=0; i<5; i++) {
//        NSString* txt = @"commentss commentss commentss commentss commentss commentss commentss commentss ";
//        UIView* sv = [self commentsView:@"https://www.baidu.com/img/bd_logo1.png" content:txt];
//        sv.wbtTop = stt;
//        stt += sv.wbtHeight;
//        [commentsView addSubview:sv];
//    }
//    [commentsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(stt));
//        make.bottom.equalTo(_frameView);
//    }];
    
}

-(UIView*) commentsView:(NSString*) imgUrl content:(NSString*) txt
{
    CGFloat sw = K_SCREEN_W - 18 - 25 -15 - 10;
    CGFloat sh = [StringUtil getTextHeight:txt forFont:[UIFont systemFontOfSize:12] andWidth:sw];
    if (sh < 25) {
        sh = 25;
    }
    UIView* sv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, sh+10)];
    UIImageView* img = [[UIImageView alloc] initWithFrame:CGRectMake(18, 5, 25, 25)];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 12;
    img.backgroundColor = [UIColor orangeColor];
    [img sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
    [sv addSubview:img];
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(58, 5, sw, sh)];
    lab.numberOfLines = 0;
    lab.text = txt;
    lab.font = [UIFont systemFontOfSize:12];
    lab.textColor = [UIColor wbt_colorWithHexValue:0x444444 alpha:1];
    [sv addSubview:lab];
    return sv;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EventCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[EventCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    SeventCommentModel * model = [self.dataList objectAtIndex:indexPath.row];
    [cell configWithModel:model];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SeventCommentModel * model = [self.dataList objectAtIndex:indexPath.row];
    return [EventCommentCell heightForCell:model];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeventCommentModel * model = [self.dataList objectAtIndex:indexPath.row];
    
    if ([model.uid integerValue] == [[[SaccountStore sharedInstance]getCurrentUid] integerValue]) {
        return YES;
    }
    
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SeventCommentModel * model = [self.dataList objectAtIndex:indexPath.row];

    // 从数据源中删除
    [self.dataList removeObjectAtIndex:indexPath.row];
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self requestDeleComment:model];
}

-(void) touchedTime
{
    
}
-(void) touchedMap
{
    
}
-(void) touchedJoin
{

}


-(void) getNearbyData
{

    SeventEngine* engine = [[SeventEngine alloc] init];
    [engine getEventComment:eventModel.eid PageSize:10 PageNum:0 Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (success) {
            NSArray * arr = data;
            for (int i = 0; i<arr.count; i++) {
                NSDictionary * dic = arr[i];
                SeventCommentModel * model = [[SeventCommentModel alloc]initWithDic:dic];
                [self.dataList addObject:model];
            }
            [self.tableView reloadData];
        }else{
            NSLog(@"失败了");
        }
    }];
}


- (void)requestAddComment:(NSString *)comment{

    SeventEngine* engine = [[SeventEngine alloc] init];
    [engine addEventComment:0 News_id:eventModel.eid content:comment commenter_id: [[[SaccountStore sharedInstance] getCurrentUid] integerValue] Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        NSArray * arr = (NSArray *)data;
        NSDictionary * dic = [[NSDictionary alloc]init];
        if (arr.count > 0) {
            dic = (NSDictionary *)[arr objectAtIndex:0];
        }
        if (success) {
            SeventCommentModel * model = [[SeventCommentModel alloc]init];
            model.content = comment;
            model.picture = @"";
            model.comment_id = (NSString *)[dic objectForKey:@"comment_id"];
            model.uid = [[SaccountStore sharedInstance]getCurrentUid];
            [self.dataList addObject:model];
            [self.tableView reloadData];
        }
    }];
}

- (void)requestDeleComment:(SeventCommentModel *)model{
   SeventEngine* engine = [[SeventEngine alloc] init];
    [engine deleteEventComment:[model.comment_id integerValue] Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            
        }
    }];
}

-(void) getPartners
{
    NSString* uid = [[SaccountStore sharedInstance] getCurrentUid];
    SeventEngine* engine = [[SeventEngine alloc] init];
//    engine 
}

- (void)refreshCommentHeader{

}

- (void)refreshCommentFooter{

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self requestAddComment:textField.text];
        [textField resignFirstResponder];
    }
    return YES;
}


@end
