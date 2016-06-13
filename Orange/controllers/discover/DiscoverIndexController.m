//
//  DiscoverIndexController.m
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "DiscoverIndexController.h"
#import "SeventModel.h"
#import "EventDetailViewController.h"
#import "SeventEngine.h"


@interface DiscoverCell : UITableViewCell
{
    UIImageView* wall;
    UILabel* txt;
}
@end
@implementation DiscoverCell
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initViews];
    return self;
}
-(void) initViews
{
    CGFloat sh = [DiscoverCell cellHeight];
    wall = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, sh)];
    wall.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:wall];
    txt = [[UILabel alloc] initWithFrame:CGRectMake(0, sh/2 -20, K_SCREEN_W, 40)];
    txt.textColor = [UIColor whiteColor];
    txt.numberOfLines = 2;
    txt.font = [UIFont systemFontOfSize:16];
    txt.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:txt];
}
+(CGFloat) cellHeight
{
    return 400 * K_SCREEN_W / 750;
}
-(void) cellContent:(NSString*) url Content:(NSString*) text
{
    [wall sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    txt.text = text;
}

@end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface DiscoverIndexController ()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel* _headerMiddleLabel;
    UITableView* _tableView;
    UIView* _selectorView;
    NSArray* _selectorData;
    BOOL _selectorShowing;
    NSMutableArray* _tableData;
}

@end



@implementation DiscoverIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableData = [NSMutableArray array];
    _selectorShowing = NO;
    _selectorData = @[@"London1",@"London2",@"London3",@"London4",@"London5",@"London6",@"London7",@"London8",@"London9",@"London10",@"London11",@"London12",@"London13",@"London14",@"London15",];
    
    [self initViews];
    [self setHeader];
    [self initSelector];
    [_tableView.mj_header beginRefreshing];
}

-(void) initViews
{
    UIView* sv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [self.view addSubview:sv];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, K_SCREEN_H-113)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    _tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];

}

-(void) setHeader
{
    UIView* header_middle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    self.navigationItem.titleView = header_middle;
    
    _headerMiddleLabel = [[UILabel alloc] init];
    _headerMiddleLabel.text = @"London";
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
    
    
}

-(void) initSelector
{
    _selectorView = [[UIView alloc] init];
    [self.view addSubview:_selectorView];
    [_selectorView setHidden:YES];
    [_selectorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, K_SCREEN_H-113));
    }];
    UIView* line = [[UIView alloc] init];
    line.backgroundColor = ORANGE_C;
    [_selectorView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectorView).offset(15);
        make.right.equalTo(_selectorView).offset(-15);
        make.top.equalTo(@0);
        make.height.equalTo(@1);
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
    CGFloat st = 1;
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
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DiscoverCell cellHeight];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverCell* cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell"];
    if (cell == nil) {
        cell = [[DiscoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DiscoverCell"];
    }
    SeventModel* model = [_tableData objectAtIndex:indexPath.row];
    [cell cellContent:model.picture Content:model.Topic];
    return cell;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     SeventModel* model = [_tableData objectAtIndex:indexPath.row];
    EventDetailViewController* ctrl = [[EventDetailViewController alloc] init];
    ctrl.eventModel = model;
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}
/**
-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
**/
#pragma mark ==== table datas
-(void) refreshHeader{[self getAllEvents:YES]; }
-(void) refreshFooter{[self getAllEvents:NO]; }

-(void) getAllEvents:(BOOL) isStart
{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    
    SeventEngine* engine = [[SeventEngine alloc] init];
    if (!isStart && [_tableData count]%10 != 0) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        return ; // no more data ...
    }
    NSInteger pageSize;
    if (isStart) {
        pageSize = 0;
    }else {
        pageSize = [_tableData count] / 10;
    }
    NSString* ps = [NSString stringWithFormat:@"%ld", pageSize];
    [engine getEventsList:@"10" PageNum:ps Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        if (success) {
            NSArray* arr = (NSArray*) data;
            if (isStart) {
                _tableData = [NSMutableArray array];
            }
            [_tableData addObjectsFromArray:arr];
            [_tableView reloadData];
        }else {
            
        }
    }];
}



@end
