//
//  CreateIndexController.m
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "CreateIndexController.h"
#import "CreateDetailController.h"

@interface CreateIndexController ()

@end

@implementation CreateIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

-(void) initViews
{
    UIImageView* image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    image.backgroundColor = [UIColor orangeColor];
    self.navigationItem.titleView = image;
    
    UIImageView* scenter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"create_more"]];
    scenter.tag = 1888 + 8;
    scenter.layer.masksToBounds = YES;
    scenter.layer.cornerRadius = 35.0f;
    [self.view addSubview:scenter];
    [scenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-32);
        make.size.mas_equalTo(CGSizeMake(70,70));
    }];
    UILabel* centerLab = [[UILabel alloc] init];
    centerLab.text = @"Others";
    centerLab.font = [UIFont systemFontOfSize:10];
    centerLab.textAlignment = NSTextAlignmentCenter;
    centerLab.textColor = [UIColor wbt_colorWithHexValue:0xbfbfbf alpha:1];
    [self.view addSubview:centerLab];
    [centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(scenter);
        make.top.equalTo(scenter.mas_bottom).offset(3);
        make.centerX.equalTo(scenter);
        make.height.equalTo(@11);
    }];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCreate:)];
    scenter.userInteractionEnabled = YES;
    [scenter addGestureRecognizer:tap];
    
    NSArray* txts = @[@"Music",@"Movie",@"Sports",@"Bar/Club",@"Outdoor",@"Restaurant",@"Party",@"Study",@"More"];
    NSArray* images = @[@"create_music",@"create_movie",@"create_sports",@"create_bar",@"create_outdoor",@"create_restaurant",@"create_party",@"create_study"];
    for (int i=0; i<8; i++) {
        CGFloat sy = sin(M_PI/4 * i) * 130;
        CGFloat sx = cos(M_PI/4 * i) * 130;
        UIImageView* simg = [[UIImageView alloc] init];
        simg.tag = 1888 + i;
        if (![StringUtil nullStr:[images objectAtIndex:i]]) {
            simg.image = [UIImage imageNamed:[images objectAtIndex:i]];
        }
        simg.layer.masksToBounds = YES;
        if ([UIScreen mainScreen].bounds.size.width  == 320) {
             simg.layer.cornerRadius = 29.0f;
        }else{
             simg.layer.cornerRadius = 37.0f;
        }
        [self.view addSubview:simg];
        [simg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(scenter).offset(sx);
            make.centerY.equalTo(scenter).offset(sy);
            if ([UIScreen mainScreen].bounds.size.width  == 320) {
                make.size.mas_equalTo(CGSizeMake(58,58));
            }else{
               make.size.mas_equalTo(CGSizeMake(74,74));
            }
        
        }];
        UITapGestureRecognizer* stap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCreate:)];
        simg.userInteractionEnabled = YES;
        [simg addGestureRecognizer:stap];
    
        UILabel* slab = [[UILabel alloc] init];
        slab.text = [txts objectAtIndex:i];
        slab.font = [UIFont systemFontOfSize:10];
        slab.textAlignment = NSTextAlignmentCenter;
        slab.textColor = [UIColor wbt_colorWithHexValue:0xbfbfbf alpha:1];
        [self.view addSubview:slab];
        [slab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(simg);
            make.top.equalTo(simg.mas_bottom).offset(3);
            make.centerX.equalTo(simg);
            make.height.equalTo(@11);
        }];
        
    }
}

-(void) gotoCreate:(UITapGestureRecognizer*) tap
{
    NSInteger tag = tap.view.tag - 1888;
    CreateDetailController* ctrl = [[CreateDetailController alloc] init];
    ctrl.eventType = tag;
    ctrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}






@end
