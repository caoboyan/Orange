//
//  EventCommentCell.h
//  Orange
//
//  Created by boyancao on 16/6/6.
//  Copyright © 2016年 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeventCommentModel.h"

@interface EventCommentCell : UITableViewCell

- (void)configWithModel:(SeventCommentModel *)model;

+ (CGFloat)heightForCell:(SeventCommentModel *)model;

@end
