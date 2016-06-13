//
//  StringUtil.m
//  Candy2
//
//  Created by Aiwa on 10/31/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "UiUtil.h"

@implementation UiUtil

+(UIButton*) get_button:(NSString*) text Full:(BOOL) isFull Blue:(BOOL) isBlue
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGFloat left = isFull ? 0 : 15;
    button.frame = CGRectMake(left, 0, K_SCREEN_W - left * 2, 44);
    if (isBlue) {
        button.backgroundColor = [UIColor blueColor];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    return button;
}




@end
