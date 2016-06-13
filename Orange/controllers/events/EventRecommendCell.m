//
//  EventRecommendCell.m
//  Orange
//
//  Created by Aiwa on 4/8/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "EventRecommendCell.h"

@interface EventRecommendCell()
{
    UIImageView* _wall;
    
    UILabel* _time;
    UILabel* _topic;
    
    UIImageView* _heart;
    
    UILabel* _date;
    
    NSInteger _tag;
}

@end

@implementation EventRecommendCell
@synthesize eventsController;

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initViews];
    }
    return self;
}

-(void) initViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat imgH = K_SCREEN_W * 400 / 750;
    _wall = [[UIImageView alloc] init];
    _wall.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_wall];
    [_wall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, imgH));
        make.left.equalTo(@0);
        make.top.equalTo(@0);
    }];
    UIView* mask = [[UIView alloc] init];
    mask.backgroundColor = [UIColor blackColor];
    mask.layer.opacity = 0.4;
    [self.contentView addSubview:mask];
    [mask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(K_SCREEN_W, 68));
        make.left.equalTo(@0);
        make.bottom.equalTo(_wall);
    }];
    
    _time = [[UILabel alloc] init];
    _time.textColor = [UIColor whiteColor];
    _time.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:_time];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.height.equalTo(@12);
        make.right.equalTo(self.contentView).offset(-50);
        make.bottom.equalTo(_wall).offset(-68 + 12 + 10);
    }];
    
    _topic = [[UILabel alloc] init];
    _topic.textColor = [UIColor whiteColor];
    _topic.numberOfLines = 0;
    _topic.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:_topic];
    [_topic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.height.equalTo(@32);
        make.right.equalTo(self.contentView).offset(-50);
        make.top.equalTo(_time.mas_bottom).offset(10);
    }];
    
    _heart = [[UIImageView alloc] init];
    [self.contentView addSubview:_heart];
    _heart.userInteractionEnabled = YES;
    _heart.image = [UIImage imageNamed:EVENT_HEART_NO_LOVE];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedHeart:)];
    [_heart addGestureRecognizer:tap];
    [_heart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(_wall).offset(-15);
    }];
    
    _date = [[UILabel alloc] init];
    _date.font = [UIFont systemFontOfSize:14];
    _date.textColor = ORANGE_C;
    [self.contentView addSubview:_date];
    [_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(@26);
        make.top.equalTo(_wall.mas_bottom);
    }];
    /// titles ...
    
}

+(CGFloat) cellHeight
{
    CGFloat imgH = K_SCREEN_W * 400 / 750;
    return imgH + 26;
}

-(void) cellContent:(SeventModel*) model
{
    // 2015-09-13T23:32:00
    
    NSString* stimeStr = [model.date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    NSString* imgUrl = [NSString stringWithFormat:@"%@%@",IMAGE_PREFIX, model.picture];
    [_wall sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    _topic.text = model.Topic;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:localzone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* sdate = [formatter dateFromString:stimeStr];
    
    NSDateFormatter* timeFormater = [[NSDateFormatter alloc] init];
    [timeFormater setTimeZone:localzone];
    [timeFormater setDateFormat:@"HH:mm"];
    
    NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setTimeZone:localzone];
    [dateFormater setDateFormat:@"dd LLL"];
    
    NSString* timeStr = [timeFormater stringFromDate:sdate];
    NSString* dateStr = [dateFormater stringFromDate:sdate];
    _time.text = timeStr;
    _date.text = dateStr;
}
-(void) cellTag:(NSInteger) tag
{
    _tag = tag;
    _heart.tag = 1234 + tag;
}

-(void) touchedHeart:(UITapGestureRecognizer*) tap
{
    NSInteger tag = tap.view.tag - 1234;
    if (self.eventsController != nil) {
        [self.eventsController touchedRecommendHeart:tag];
    }
}


@end
