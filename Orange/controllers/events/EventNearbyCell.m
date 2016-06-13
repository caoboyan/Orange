//
//  EventNearbyCell.m
//  Orange
//
//  Created by Aiwa on 4/8/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "EventNearbyCell.h"

@interface EventNearbyCell()
{
    UIView* _frm1;
    UIView* _frm2;
    
    UIImageView* _wall1;
    UILabel* _time1;
    UILabel* _distance1;
    UILabel* _topic1;
    UIImageView* _heart1;
    
    UIImageView* _wall2;
    UILabel* _time2;
    UILabel* _distance2;
    UILabel* _topic2;
    UIImageView* _heart2;
    
    
    NSInteger _tag;
}

@end

@implementation EventNearbyCell
@synthesize eventsController;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}

+(CGFloat) cellHeight
{
    CGFloat imgH = 354 * K_SCREEN_W / 750;
    return imgH + 100;  /// 10 is spacing ..
}

-(void) initViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat imgH = 354 * K_SCREEN_W / 750;
    CGFloat frameW = (K_SCREEN_W - 32 - 10 ) / 2;
    CGFloat frameH = [EventNearbyCell cellHeight] -10;
    
    _frm1 = [[UIView alloc] init];
    _frm1.layer.borderColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1].CGColor;
    _frm1.layer.borderWidth = 1.0f;
    _frm1.layer.masksToBounds = YES;
    _frm1.layer.cornerRadius = 3.0f;
    UITapGestureRecognizer* stap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedFrame:)];
    _frm1.userInteractionEnabled = YES;
    [_frm1 addGestureRecognizer:stap1];
    [self.contentView addSubview:_frm1];
    [_frm1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frameW, frameH));
        make.left.equalTo(@16);
        make.top.equalTo(@0);
    }];
    
    _wall1 = [[UIImageView alloc] init];
    _wall1.backgroundColor = [UIColor greenColor];
    [_frm1 addSubview:_wall1];
    [_wall1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_frm1);
        make.height.equalTo(@(imgH));
        make.left.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
    _distance1 = [[UILabel alloc] init];
    _distance1.font = [UIFont systemFontOfSize:10];
    _distance1.textAlignment = NSTextAlignmentRight;
    _distance1.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    [_frm1 addSubview:_distance1];
    [_distance1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_frm1).offset(-5);
        make.top.equalTo(_wall1.mas_bottom).offset(10);
    }];
    
    _time1 = [[UILabel alloc] init];
    _time1.font = [UIFont systemFontOfSize:10];
    _time1.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    [_frm1 addSubview:_time1];
    [_time1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_frm1).offset(5);
        make.top.equalTo(_wall1.mas_bottom).offset(10);
    }];
    
    _topic1 = [[UILabel alloc] init];
    _topic1.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    _topic1.numberOfLines = 0;
    _topic1.font = [UIFont boldSystemFontOfSize:14];
    [_frm1 addSubview:_topic1];
    [_topic1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(_frm1).offset(-10);
        make.height.equalTo(@50);
        make.top.equalTo(_time1.mas_bottom).offset(10);
    }];
    
    _heart1 = [[UIImageView alloc] init];
    _heart1.image = [UIImage imageNamed:EVENT_HEART_NO_LOVE];
    [_frm1 addSubview:_heart1];
    _heart1.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedHeart:)];
    [_heart1 addGestureRecognizer:tap1];
    [_heart1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(@-5);
        make.bottom.equalTo(_frm1).offset(-5);
    }];
    
    _frm2 = [[UIView alloc] init];
    _frm2.layer.borderColor = [UIColor wbt_colorWithHexValue:0xdddddd alpha:1].CGColor;
    _frm2.layer.borderWidth = 1.0f;
    _frm2.layer.masksToBounds = YES;
    _frm2.layer.cornerRadius = 3.0f;
    UITapGestureRecognizer* stap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedFrame:)];
    _frm2.userInteractionEnabled = YES;
    [_frm2 addGestureRecognizer:stap2];
    [self.contentView addSubview:_frm2];
    [_frm2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frameW, frameH));
        make.left.equalTo(_frm1.mas_right).offset(10);
        make.top.equalTo(@0);
    }];
    
    _wall2 = [[UIImageView alloc] init];
    _wall2.backgroundColor = [UIColor greenColor];
    [_frm2 addSubview:_wall2];
    [_wall2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_frm2);
        make.height.equalTo(@(imgH));
        make.left.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
    _distance2 = [[UILabel alloc] init];
    _distance2.font = [UIFont systemFontOfSize:10];
    _distance2.textAlignment = NSTextAlignmentRight;
    _distance2.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    [_frm2 addSubview:_distance2];
    [_distance2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_frm2).offset(-5);
        make.top.equalTo(_wall2.mas_bottom).offset(10);
    }];
    
    _time2 = [[UILabel alloc] init];
    _time2.font = [UIFont systemFontOfSize:10];
    _time2.textColor = [UIColor wbt_colorWithHexValue:0x666666 alpha:1];
    [_frm2 addSubview:_time2];
    [_time2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_frm2).offset(5);
        make.top.equalTo(_wall2.mas_bottom).offset(10);
    }];
    
    _topic2 = [[UILabel alloc] init];
    _topic2.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    _topic2.numberOfLines = 0;
    _topic2.font = [UIFont boldSystemFontOfSize:14];
    [_frm2 addSubview:_topic2];
    [_topic2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.height.equalTo(@50);
        make.right.equalTo(_frm2).offset(-10);
        make.top.equalTo(_time2.mas_bottom).offset(10);
    }];
    
    _heart2 = [[UIImageView alloc] init];
    _heart2.image = [UIImage imageNamed:EVENT_HEART_NO_LOVE];
    [_frm2 addSubview:_heart2];
    _heart2.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedHeart:)];
    [_heart2 addGestureRecognizer:tap2];
    [_heart2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(@-5);
        make.bottom.equalTo(_frm2).offset(-5);
    }];
    
}



-(void) cellContent:(NSArray*) models
{
    SeventModel* model1 = [models objectAtIndex:0];
    [_wall1 sd_setImageWithURL:[NSURL URLWithString:model1.picture]];
    _topic1.text = model1.Topic;
    _time1.text = model1.date;
    ///// heart1 ...
    if ([models count] == 2) {
        [_frm2 setHidden:NO];
        SeventModel* model2 = [models objectAtIndex:1];
        [_wall2 sd_setImageWithURL:[NSURL URLWithString:model2.picture]];
        _topic2.text = model2.Topic;
        _time2.text = model2.date;
        ///// heart1 ...
        
    }else {
        [_frm2 setHidden:YES];
    }
    ////
    _distance1.text = @"100miles";
    _distance2.text = @"100miles";
}
-(void) cellTag:(NSInteger) tag
{
    _tag = tag;
    _heart1.tag = 1234 + tag;
    _heart2.tag = 1235 + tag;
    
    _frm1.tag = 2234 + tag*2;
    _frm2.tag = 2235 + tag*2;
}

-(void) touchedHeart:(UITapGestureRecognizer*) tap
{
    NSInteger tag = tap.view.tag - 1234;
    if (self.eventsController != nil) {
        [self.eventsController touchedNearbyHeart:tag];
    }
}
-(void) touchedFrame:(UITapGestureRecognizer*) tap
{
    NSInteger tag = tap.view.tag - 2234;
    if (self.eventsController != nil) {
        [self.eventsController touchedNearbyFrame:tag];
    }
}


@end
