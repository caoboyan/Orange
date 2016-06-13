//
//  MapController.m
//  MapTest
//
//  Created by Aiwa on 5/10/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "MapController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Masonry.h"

@interface MapController ()<MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>
{
    MKMapView* _mapView;
    NSMutableArray* _coordArr;
    CLLocationManager* _locationManager;
    
    UITextField* _searchInput;
    
    UILabel* _addr;
    UILabel* _building;
    UIView* infos;
    NSInteger _selectedIndex;
}

@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

-(void) initViews
{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    _coordArr = [[NSMutableArray alloc]init];
    [self.view addSubview:_mapView];
    
    _searchInput = [[UITextField alloc] init];
    _searchInput.backgroundColor = [UIColor whiteColor];
    _searchInput.font = [UIFont systemFontOfSize:12];
    _searchInput.placeholder = @"words to search";
    _searchInput.returnKeyType = UIReturnKeyGo;
    _searchInput.delegate = self;
    _searchInput.layer.borderColor = [UIColor orangeColor].CGColor;
    _searchInput.layer.borderWidth = 1.0f;
    _searchInput.layer.masksToBounds = YES;
    _searchInput.layer.cornerRadius = 5.0f;
    _searchInput.layer.opacity = 0.5;
    UIView* sleftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _searchInput.leftView = sleftView;
    _searchInput.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_searchInput];
    [_searchInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(self.view).offset(30);
        make.height.equalTo(@30);
    }];
    
    
    infos = [[UIView alloc] init];
    infos.layer.masksToBounds = YES;
    infos.layer.cornerRadius = 5.0f;
    infos.layer.borderColor = [UIColor orangeColor].CGColor;
    infos.layer.borderWidth = 1.0f;
    infos.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infos];
    [infos setHidden:YES];
    [infos mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-30);
        make.height.equalTo(@50);
    }];
    
    _building = [[UILabel alloc] init];
    _building.font = [UIFont systemFontOfSize:15];
    _building.textColor = [UIColor orangeColor];
    [infos addSubview:_building];
    [_building mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infos).offset(10);
        make.right.equalTo(infos).offset(-80);
        make.top.equalTo(infos).offset(5);
        make.height.equalTo(@20);
    }];
    
    _addr = [[UILabel alloc] init];
    _addr.font = [UIFont systemFontOfSize:12];
    _addr.textColor = [UIColor orangeColor];
    [infos addSubview:_addr];
    [_addr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infos).offset(10);
        make.right.equalTo(infos).offset(-80);
        make.bottom.equalTo(infos).offset(-5);
        make.height.equalTo(@20);
    }];
    
    UIButton* sb = [UIButton buttonWithType:UIButtonTypeCustom];
    [sb setBackgroundColor:[UIColor orangeColor]];
    [sb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sb setTitle:@"OK" forState:UIControlStateNormal];
    sb.layer.masksToBounds = YES;
    sb.layer.cornerRadius = 5.0f;
    [sb addTarget:self action:@selector(touchedOk) forControlEvents:UIControlEventTouchUpInside];
    [infos addSubview:sb];
    [sb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 35));
        make.right.equalTo(infos).offset(-10);
        make.centerY.equalTo(infos);
    }];
    
    /// start location..
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    [self getLocation];
}



- (void) searchTxt:(NSString*) text {
    MKLocalSearchRequest* request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = text;
    MKLocalSearch* localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        _coordArr = [NSMutableArray array];
        NSArray* arr = response.mapItems;
        NSMutableArray* points = [NSMutableArray array];
        for (MKMapItem *mapItem in arr) {
            NSString* sname = mapItem.placemark.name;
            if (sname == nil) {
                sname = @"";
            }
            
            NSString* scity = mapItem.placemark.locality;
            if (scity == nil) {
                scity = @"";
            }
            
            NSString* sstreet = mapItem.placemark.thoroughfare;
            if (sstreet == nil) {
                sstreet = @"";
            }
            NSDictionary* dict = @{
                                   @"latitude": [NSNumber numberWithDouble:mapItem.placemark.location.coordinate.latitude],
                                   @"longitude": [NSNumber numberWithDouble:mapItem.placemark.location.coordinate.longitude],
                                   @"name" : sname,
                                   @"city" : scity,
                                   @"street" : sstreet};
            [_coordArr addObject:dict];
        }
        [self addMaps:_coordArr];
        NSDictionary* center = [self calcCenterCoordinate:_coordArr];
        [self setCenter:[_coordArr objectAtIndex:0]];
    }];
}

-(void) setCenter:(NSDictionary*) dict
{
    double lat = [[dict objectForKey:@"latitude"] doubleValue];
    double lon = [[dict objectForKey:@"longitude"] doubleValue];
    MKCoordinateRegion theRegion;
    theRegion.center=CLLocationCoordinate2DMake(lat,lon);
    theRegion.span=MKCoordinateSpanMake(0.6, 0.6);
    [_mapView setRegion:theRegion animated:YES];
}

-(void) addMaps:(NSArray<NSDictionary*>*) arr
{
    [_mapView removeAnnotations:_mapView.annotations];
    for (NSDictionary* dict in arr) {
        double lat = [[dict objectForKey:@"latitude"] doubleValue];
        double lon = [[dict objectForKey:@"longitude"] doubleValue];
        
        MKPointAnnotation* annotation=[[MKPointAnnotation alloc]init];
        
        annotation.coordinate=CLLocationCoordinate2DMake(lat, lon);
        [_mapView addAnnotation:annotation];
    }
    if ([arr count] > 0) {
        _selectedIndex = 0;
        [self setCurrentPoint];
    }
}

-(NSDictionary*) calcCenterCoordinate:(NSArray<NSDictionary*>*) arr
{
    double lats = 0;
    double lons = 0;
    for (int i=0; i<[arr count]; i++) {
        NSDictionary* dict = [arr objectAtIndex:i];
        double lat = [[dict objectForKey:@"latitude"] doubleValue];
        double lon = [[dict objectForKey:@"longitude"] doubleValue];
        lats += lat;
        lons += lon;
    }
    double slat = lats / [arr count];
    double slon = lons / [arr count];
    return @{
             @"latitude" : [NSNumber numberWithDouble:slat],
             @"longitude" : [NSNumber numberWithDouble:slon]
        };
}

#pragma mark ====== customs maps

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0)
{
    MKPointAnnotation *annotation = view.annotation;
    CLLocationCoordinate2D coordinate = annotation.coordinate;
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.2;
    theSpan.longitudeDelta=0.2;
    
    MKCoordinateRegion theRegion;
    theRegion.center=coordinate;
    theRegion.span=theSpan;
    
    //    _mapView.region = theRegion;
    [_mapView setRegion:theRegion animated:YES];
    
    for(NSInteger i=0; i<[_coordArr count]; i++) {
        NSDictionary* dictx = [_coordArr objectAtIndex:i];
        double lat = [[dictx objectForKey:@"latitude"] floatValue];
        double lon = [[dictx objectForKey:@"longitude"] floatValue];
        double latx = lat - coordinate.latitude;
        double lonx = lon - coordinate.longitude;
        if((latx < 0.001 && latx > -0.001) || (lonx < 0.001 && lonx > -0.001)) {
            _selectedIndex = i;
            [self setCurrentPoint];
            break;
        }
    }
}

-(void) setCurrentPoint
{
    NSDictionary* dict = [_coordArr objectAtIndex:_selectedIndex];
    NSString* addr = [dict objectForKey:@"street"];
    NSString* city = [dict objectForKey:@"city"];
    NSString* building = [dict objectForKey:@"name"];
    _addr.text  = [NSString stringWithFormat:@"%@, %@", addr, city];
    _building.text = building;
    [infos setHidden:NO];
}


#pragma mark ==== about maps locations ..

//////定位，获取位置相关
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
        NSDictionary* sdict = @{
            @"latitude" : [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude],
            @"longitude" : [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude]
        };
        [self setCenter:sdict];
    }
}

#pragma mark ==== textfield delegate ...
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString* txt = _searchInput.text;
    if (txt != nil && ![txt isEqualToString:@""]) {
        [textField resignFirstResponder];
        [self searchTxt:txt];
        return YES;
    }
    return NO;
}

////
-(void) touchedOk
{
    if (_selectedIndex != -1) {
        NSDictionary* addr = [_coordArr objectAtIndex:_selectedIndex];
        if (self.delegate != nil) {
            [self.delegate didAddrSelected:addr];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}



@end
