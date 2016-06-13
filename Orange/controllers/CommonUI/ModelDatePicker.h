//
//  ModelDatePicker.h
//  Candy2
//
//  Created by Aiwa on 11/4/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "CommonLayer.h"

@protocol CustomDatePickerProtocol <NSObject>
    -(void) customDatePickerDidDChanged:(UIDatePicker*) picker;
@optional
    -(void) customDatePickerOkDidClicked:(UIDatePicker*) picker;
@end

@interface ModelDatePicker : CommonLayer


@property (nonatomic, weak) id<CustomDatePickerProtocol> delegate;

- (instancetype)initWithFrame:(CGRect)frame DateType:(UIDatePickerMode) dateModel;

@end
