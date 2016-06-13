//
//  MessageFriendCell.m
//  Orange
//
//  Created by Aiwas on 5/10/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "MessageFriendCell.h"

@interface MessageFriendCell()
{
    UILabel *_nameLabel;
    UILabel *_timeLabel;
    UILabel *_unreadLabel;
    UILabel *_detailLabel;
    UIView *_lineView;
    UIImageView *imageV;
}

@end

@implementation MessageFriendCell

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
    imageV = [[UIImageView alloc] init];
    //        imageV.layer.masksToBounds = YES;
    //        imageV.layer.cornerRadius = 25.0f;
    [self.contentView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.equalTo(imageV.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-100);
        make.height.equalTo(@15);
    }];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.backgroundColor = [UIColor clearColor];
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textColor = [UIColor wbt_colorWithHexValue:0x999999 alpha:1];
    [self.contentView addSubview:_detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(12);
        make.left.equalTo(imageV.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.equalTo(@16);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor wbt_colorWithHexValue:0xbfbfbf alpha:1];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(85, 12));
    }];
    
    _unreadLabel = [[UILabel alloc] init];
    _unreadLabel.backgroundColor = [UIColor redColor];
    _unreadLabel.textColor = [UIColor whiteColor];
    _unreadLabel.textAlignment = NSTextAlignmentCenter;
    _unreadLabel.font = [UIFont systemFontOfSize:10];
    _unreadLabel.layer.cornerRadius = 10;
    _unreadLabel.clipsToBounds = YES;
    [self.contentView addSubview:_unreadLabel];
    [_unreadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(imageV);
        make.top.equalTo(imageV);
    }];
}

+(CGFloat) cellHeight
{
    return 75;
}

-(void) cellContent:(SmessageFriend*) model
{
    _nameLabel.textColor = [UIColor wbt_colorWithHexValue:0x222222 alpha:1];
    _nameLabel.text = model.UNAME;
    NSString* imagename = [StringUtil imageNameSplit:model.PICTURE];
    NSString* imgUrl = [NSString stringWithFormat:@"%@%@",IMAGE_PREFIX, imagename];
    [imageV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:IMAGE_PLACE];
    
    if ([StringUtil nullStr:model.detailMsg]) {
        _detailLabel.text = @"暂无消息";
    }else {
        _detailLabel.text = model.detailMsg;
    }
    _timeLabel.text = model.time;
    if (model.unreadCount > 0) {
        if (model.unreadCount < 9) {
            _unreadLabel.font = [UIFont systemFontOfSize:13];
        }else if(model.unreadCount > 9 && model.unreadCount < 99){
            _unreadLabel.font = [UIFont systemFontOfSize:12];
        }else{
            _unreadLabel.font = [UIFont systemFontOfSize:10];
        }
        [_unreadLabel setHidden:NO];
        [self.contentView bringSubviewToFront:_unreadLabel];
        _unreadLabel.text = [NSString stringWithFormat:@"%ld",model.unreadCount];
    }else{
        [_unreadLabel setHidden:YES];
    }
}



@end
