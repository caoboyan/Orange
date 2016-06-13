//
//  EventsIndexController.m
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "EventsIndexController.h"
#import "SeventEngine.h"
#import "EventDetailViewController.h"


#import "EventRecommendCell.h"
#import "EventNearbyCell.h"

#import <CoreLocation/CoreLocation.h>

#import "EventDetailViewController.h"

#import "OtherProfileViewController.h"

@interface EventsIndexController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    UIScrollView* _bannerView;
    UIPageControl* _headPage;
    
    UITableView* _recommendTable;
    UITableView* _nearbyTable;
    NSMutableArray* _dataRecommon;
    NSMutableArray* _dataNearby;
    
    UILabel* _recommonBtn;
    UIView* _recommonLine;
    
    UILabel* _nearbyBtn;
    UIView* _nearbyLine;
    
    NSTimer* _timer;
    CGFloat _headerH;
    
    BOOL _showingRecommend;
    //// headers ..
    UILabel* _headerLeftLabel;
    UILabel* _headerMiddleLabel;
    UIImageView* _headerRight;
    ////search ...
    BOOL _searchShowing;
    UIView* _searchView; 
    UITextField* _searchInput;
    
    CLLocationManager* _locationManager;
    
    NSString* _lat;
    NSString* _lon;
}

@end

@implementation EventsIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleText:@"events"];
    
    _dataRecommon = [NSMutableArray array];
    _dataNearby = [NSMutableArray array];
    
    _headerH = K_SCREEN_W*175/750;
    _showingRecommend = YES;
    
    _searchShowing = NO;
    _lat = @"0";
    _lon = @"0";
    
    [self initViews];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
}

-(void) initViews
{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    _headerH = K_SCREEN_W*264/750;
    [self setTitleText:@"三颗糖"];
    UIView* __tmpview = [[UIView alloc] init];
    [self.view addSubview:__tmpview];

    _bannerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, _headerH)];
    _bannerView.backgroundColor = [UIColor grayColor];
    _bannerView.showsHorizontalScrollIndicator = NO;
    _bannerView.showsVerticalScrollIndicator = NO;
    _bannerView.delegate = self;
    _bannerView.pagingEnabled = YES;
    _bannerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedHead)];
    [_bannerView addGestureRecognizer:tap];
    [self.view addSubview:_bannerView];
    
    _headPage = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _headerH-25, K_SCREEN_W, 20)];
    _headPage.backgroundColor = [UIColor clearColor];
    _headPage.pageIndicatorTintColor = [UIColor wbt_colorWithHexValue:0xFFFFFF alpha:0.4f];
    _headPage.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self.view addSubview:_headPage];
    
    UIView* smenus = [[UIView alloc] init];
    smenus.backgroundColor = [UIColor wbt_colorWithHexValue:0xffffff alpha:1];
    [self.view addSubview:smenus];
    [smenus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 32));
        make.left.equalTo(@0);
        make.top.equalTo(_bannerView.mas_bottom);
    }];
    
    _recommonBtn = [[UILabel alloc] init];
    _recommonBtn.font = [UIFont systemFontOfSize:11];
    _recommonBtn.textColor = [UIColor wbt_colorWithHexValue:0x322C2E alpha:1];
    _recommonBtn.text = @"RECOMMEND";
    UITapGestureRecognizer* tap_recommon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedRecommon)];
    _recommonBtn.userInteractionEnabled = YES;
    [_recommonBtn addGestureRecognizer:tap_recommon];
    
    [smenus addSubview:_recommonBtn];
    [_recommonBtn sizeToFit];
    [_recommonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@7);
    }];
    _recommonLine = [[UIView alloc] init];
    _recommonLine.backgroundColor = ORANGE_C;
    [smenus addSubview:_recommonLine];
    [_recommonLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_recommonBtn);
        make.top.equalTo(_recommonBtn.mas_bottom).offset(2);
        make.width.mas_equalTo(_recommonBtn);
        make.height.equalTo(@2);
    }];
    UIView* sepline = [[UIView alloc] init];
    sepline.backgroundColor = [UIColor wbt_colorWithHexValue:0xE8ECED alpha:1];
    [smenus addSubview:sepline];
    [sepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@5);
        make.left.equalTo(_recommonLine.mas_right).offset(10);
        make.height.equalTo(@16);
        make.width.equalTo(@2);
    }];
    
    _nearbyBtn = [[UILabel alloc] init];
    _nearbyBtn.font = [UIFont systemFontOfSize:11];
    _nearbyBtn.textColor = [UIColor wbt_colorWithHexValue:0xE5E8EA alpha:1];
    _nearbyBtn.text = @"NEARBY";
    UITapGestureRecognizer* tap_nearby = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedNearby)];
    _nearbyBtn.userInteractionEnabled = YES;
    [_nearbyBtn addGestureRecognizer:tap_nearby];
    
    [smenus addSubview:_nearbyBtn];
    [_nearbyBtn sizeToFit];
    [_nearbyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sepline.mas_right).offset(10);
        make.top.equalTo(@7);
    }];
    _nearbyLine = [[UIView alloc] init];
    [_nearbyLine setHidden:YES];
    _nearbyLine.backgroundColor = ORANGE_C;
    [smenus addSubview:_nearbyLine];
    [_nearbyLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nearbyBtn);
        make.top.equalTo(_nearbyBtn.mas_bottom).offset(2);
        make.width.mas_equalTo(_nearbyBtn);
        make.height.equalTo(@2);
    }];
    
    /// 2 tables
    _recommendTable = [[UITableView alloc] init];
    _recommendTable.dataSource = self;
    _recommendTable.delegate = self;
    _recommendTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_recommendTable];
    [_recommendTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smenus.mas_bottom);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
        make.left.equalTo(@0);
    }];
    _recommendTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshRecommonHeader)];
    _recommendTable.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshRecommonFooter)];
    
    _nearbyTable = [[UITableView alloc] init];
    [_nearbyTable setHidden:YES];
    _nearbyTable.dataSource = self;
    _nearbyTable.delegate = self;
    _nearbyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_nearbyTable];
    [_nearbyTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(smenus.mas_bottom);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
        make.left.equalTo(@0);
    }];
    _nearbyTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshNearbyHeader)];
    _nearbyTable.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshNearbyFooter)];
    //// view for headers ... //////////////////////////////////////////
    UIView* header_left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:header_left];
    _headerLeftLabel = [[UILabel alloc] init];
    _headerLeftLabel.font = [UIFont systemFontOfSize:14];
    _headerLeftLabel.text = @"Today";
    _headerLeftLabel.textColor = ORANGE_C;
    [header_left addSubview:_headerLeftLabel];
    [_headerLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.centerY.equalTo(header_left);
    }];
    UITapGestureRecognizer* tapHeaderLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedHeaderLeft)];
    header_left.userInteractionEnabled = YES;
    [header_left addGestureRecognizer:tapHeaderLeft];
    
    UIView* header_middle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    self.navigationItem.titleView = header_middle;
    _headerMiddleLabel = [[UILabel alloc] init];
    _headerMiddleLabel.text = @"London";
    _headerMiddleLabel.font = [UIFont systemFontOfSize:14];
    _headerMiddleLabel.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    [header_middle addSubview:_headerMiddleLabel];
    [_headerMiddleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header_middle);
        make.centerY.equalTo(header_middle);
    }];
    UITapGestureRecognizer* tapHeaderMiddle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedHeaderMiddle)];
    header_middle.userInteractionEnabled = YES;
    [header_middle addGestureRecognizer:tapHeaderMiddle];
    
    UIView* header_right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:header_right];
    _headerRight = [[UIImageView alloc] init];
    _headerRight.backgroundColor = [UIColor purpleColor];
    [header_right addSubview:_headerRight];
    [_headerRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22, 22));
        make.right.equalTo(@0);
        make.centerY.equalTo(header_right);
    }];
    UITapGestureRecognizer* tapHeaderRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedHeaderRight)];
    header_right.userInteractionEnabled = YES;
    [header_right addGestureRecognizer:tapHeaderRight];
    
    //// search////
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(K_SCREEN_W, 0, K_SCREEN_W, 40)];
    _searchView.layer.opacity = 0.7;
    _searchView.backgroundColor = [UIColor wbt_colorWithHexValue:0xffffff alpha:1];
    [self.view addSubview:_searchView];
    _searchInput = [[UITextField alloc] init];
    _searchInput.layer.borderColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1].CGColor;
    _searchInput.layer.borderWidth = 0.5;
    _searchInput.layer.masksToBounds = YES;
    _searchInput.layer.cornerRadius = 5.0f;
    _searchInput.returnKeyType = UIReturnKeyGo;
    _searchInput.font = [UIFont systemFontOfSize:13];
    _searchInput.backgroundColor = [UIColor whiteColor];
    _searchInput.placeholder = @"please input search text";
    [_searchView addSubview:_searchInput];
    [_searchInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_searchView).offset(15);
        make.right.equalTo(_searchView).offset(-15);
        make.centerY.equalTo(_searchView);
        make.height.equalTo(@20);
    }];
    
}
////menu change ..
-(void) touchedRecommon
{
    if (!_showingRecommend) {
        _showingRecommend = YES;
        _nearbyBtn.textColor = [UIColor wbt_colorWithHexValue:0xE5E8EA alpha:1];
        [_nearbyLine setHidden:YES];
        _recommonBtn.textColor = [UIColor wbt_colorWithHexValue:0x322C2E alpha:1];
        [_recommonLine setHidden:NO];
        [_recommendTable setHidden:NO];
        [_nearbyTable setHidden:YES];
    }
}
-(void) touchedNearby
{
    if (_showingRecommend) {
        _showingRecommend = NO;
        _nearbyBtn.textColor = [UIColor wbt_colorWithHexValue:0x322C2E alpha:1];
        [_nearbyLine setHidden:NO];
        _recommonBtn.textColor = [UIColor wbt_colorWithHexValue:0xE5E8EA alpha:1];
        [_recommonLine setHidden:YES];
        [_recommendTable setHidden:YES];
        [_nearbyTable setHidden:NO];
        if (_dataNearby == nil || [_dataNearby count] == 0) {
            [_nearbyTable.mj_header beginRefreshing];
        }
    }
}

//// banner
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat idx = scrollView.contentOffset.x / K_SCREEN_W;
    _headPage.currentPage = (int) idx;
}

-(void) tappedHead
{
    NSInteger idx = _headPage.currentPage;
//    SimageModel *imageModel = [_headData objectAtIndex:idx];
//    NSString *url = imageModel.web_url;
//    if (url != nil) {
//        TryListenViewController *tryVc = [[TryListenViewController alloc] init];
//        tryVc.urlStr = url;
//        tryVc.stitle = imageModel.title;
//        tryVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:tryVc animated:YES];
//    }
}

-(void) getLocation
{
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        BOOL enable = [CLLocationManager locationServicesEnabled];
        int status = [CLLocationManager authorizationStatus];
        if (!enable || status < 3) {
            [_locationManager requestAlwaysAuthorization];
        }
    }
    [_locationManager startUpdatingLocation];
}
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    if (currentLocation.coordinate.latitude != 0 ) {
        [_locationManager stopUpdatingLocation];
        _lat = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
        _lon = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
        if (_dataRecommon == nil || [_dataRecommon count] == 0) {
            [_recommendTable.mj_header beginRefreshing];
        }
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(intervalBanner) userInfo:nil repeats:YES];
    [self getLocation];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void) intervalBanner
{
    NSInteger idx = _headPage.currentPage;
    idx ++;
//    if (idx >= [_headData count]) {
//        idx = 0;
//    }
    _headPage.currentPage = idx;
    [_bannerView scrollRectToVisible:CGRectMake(idx*K_SCREEN_W, 0, K_SCREEN_W, _headerH) animated:YES];
}

////// delegate & datasource of 2 tables
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _recommendTable) {
        return [_dataRecommon count];
    }else {
        NSInteger count = [_dataNearby count];
        return count / 2 + count % 2 ;
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _recommendTable) {
        return [EventRecommendCell cellHeight];
    }else {
        return [EventNearbyCell cellHeight];
    }
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _recommendTable) {
        SeventModel* model = [_dataRecommon objectAtIndex:indexPath.row];
        EventRecommendCell* cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];
        if (cell == nil) {
            cell = [[EventRecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recommendCell"];
        }
        [cell cellContent:model];
        [cell cellTag:indexPath.row];
        return cell;
    }else {
        SeventModel* model = [_dataNearby objectAtIndex:indexPath.row*2];
        EventNearbyCell* cell = [tableView dequeueReusableCellWithIdentifier:@"nearbyCell"];
        if (cell == nil) {
            cell = [[EventNearbyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nearbyCell"];
        }
        //// model, tag ...
        NSArray* arr;
        if ([_dataNearby count] >= indexPath.row*2 +1) {
            arr = @[model, [_dataNearby objectAtIndex:indexPath.row*2+1]];
        }else {
            arr = @[model];
        }
        [cell cellContent:arr];
        cell.eventsController = self;
        [cell cellTag:indexPath.row];
        return cell;
    }
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _recommendTable) {
        SeventModel* model = [_dataRecommon objectAtIndex:indexPath.row];
        [self goDetail:model];
    }
}

/// table heart touch and model touch ..
-(void) touchedRecommendHeart:(NSInteger) idx
{
    SeventModel* model = [_dataRecommon objectAtIndex:idx];
}
-(void) touchedNearbyHeart:(NSInteger) idx
{
    SeventModel* model = [_dataNearby objectAtIndex:idx];
}
-(void) touchedNearbyFrame:(NSInteger) idx
{
    SeventModel* model = [_dataNearby objectAtIndex:idx];
    [self goDetail:model];
}

-(void) goDetail:(SeventModel*) model
{
    EventDetailViewController* ctrl = [[EventDetailViewController alloc] init];
    ctrl.eventModel = model;
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}

////////////////////////////////////////////////

///// header touch
-(void) touchedHeaderLeft
{
    //// test
//    EventDetailViewController *ctrl = [[EventDetailViewController alloc] init];
    
    OtherProfileViewController *ctrl = [[OtherProfileViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}
-(void) touchedHeaderMiddle
{
    
}
-(void) touchedHeaderRight
{
    if (_searchShowing) {
        _searchView.wbtLeft = 0;
        [UIView animateWithDuration:0.3 animations:^{
            _searchView.wbtLeft = K_SCREEN_W;
        }];
        _searchShowing = NO;
        [_searchInput resignFirstResponder];
    }else {
        _searchView.wbtLeft = K_SCREEN_W;
        [UIView animateWithDuration:0.3 animations:^{
            _searchView.wbtLeft = 0;
        }];
        [_searchInput becomeFirstResponder];
        _searchShowing = YES;
    }
}

//// get table datas
-(void) refreshRecommonHeader
{
    [self getRecommendData:YES];
}
-(void) refreshRecommonFooter
{
    [self getRecommendData:NO];
}
-(void) refreshNearbyHeader
{
    [self getNearbyData:YES];
}
-(void) refreshNearbyFooter
{
    [self getNearbyData:NO];
}


-(void) getRecommendData:(BOOL) isStart
{
    if (!isStart && [_dataRecommon count]%10 != 0) {
        [_recommendTable.mj_header endRefreshing];
        [_recommendTable.mj_footer endRefreshing];
        return;
    }
    NSString* uid = [[SaccountStore sharedInstance] getCurrentUid];
    NSInteger start = isStart ? 0 : [_dataRecommon count]/10;
    SeventEngine* engine = [[SeventEngine alloc] init];
    [engine userRecommendEventList:@"0" Pagesize:10 PageNum:start Uid:uid Lat:_lat Lon:_lon Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        [_recommendTable.mj_header endRefreshing];
        [_recommendTable.mj_footer endRefreshing];
        if (success) {
            if (isStart) {
                _dataRecommon = [NSMutableArray array];
            }
            NSArray* arr = (NSArray*) data;
            [_dataRecommon addObjectsFromArray:arr];
            [_recommendTable reloadData];
        }else {
            [self requestError:error];
        }
    }];
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event{

}

-(void) getNearbyData:(BOOL) isStart
{
    if (!isStart && [_dataNearby count]%10 != 0) {
        [_nearbyTable.mj_header endRefreshing];
        [_nearbyTable.mj_footer endRefreshing];
        return;
    }
    NSInteger start = isStart ? 0 : [_dataNearby count]/10;
    SeventEngine* engine = [[SeventEngine alloc] init];
    [engine userNearbyEventList:@"0" Pagesize:10 PageNum:start Lat:_lat Lon:_lon Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        [_nearbyTable.mj_header endRefreshing];
        [_nearbyTable.mj_footer endRefreshing];
        if (success) {
            if (isStart) {
                _dataNearby = [NSMutableArray array];
            }
            NSArray* arr = (NSArray*) data;
            [_dataNearby addObjectsFromArray:arr];
            [_nearbyTable reloadData];
        }else {
            [self requestError:error];
        }
    }];
}


@end
