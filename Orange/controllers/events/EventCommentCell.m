



//
//  EventCommentCell.m
//  Orange
//
//  Created by boyancao on 16/6/6.
//  Copyright © 2016年 Aiwa. All rights reserved.
//

#import "EventCommentCell.h"

@interface EventCommentCell()

@property (nonatomic, strong) UILabel * commentLabel;

@property (nonatomic, strong) UIImageView * avatarImageView;

@end


@implementation EventCommentCell

+ (CGFloat)heightForCell:(SeventCommentModel *)model{
    CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:13.f] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, MAXFLOAT)];
    if (size.height < 30) {
        return 50;
    }else{
        return 20+size.height;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUP];
    }
    return self;
}


- (void)setUP{
    self.commentLabel = [[UILabel alloc]init];
    [self addSubview:self.commentLabel];
    
    self.avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    self.avatarImageView.layer.cornerRadius = 15;
    self.avatarImageView.clipsToBounds = YES;
    [self addSubview:self.avatarImageView];
    
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame) + 10, 10, [UIScreen mainScreen].bounds.size.width - 60, 0);
}

- (void)configWithModel:(SeventCommentModel *)model{
    self.commentLabel.text = model.content;
    CGSize size = [model.content sizeWithFont:[UIFont systemFontOfSize:13.f] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, MAXFLOAT)];
    CGRect rect = self.commentLabel.frame;
    rect.size.height = size.height;
    self.commentLabel.frame = rect;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.picture]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
