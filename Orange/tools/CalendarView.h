//
//  CalendarView.h
//  Teeeeeeeee
//
//  Created by Aiwa on 3/26/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol calendarSelectedProtocal <NSObject>

-(void) selectedDate:(NSDate*) startDate EndDate:(NSDate*) endDate;

@end

@interface CalendarView : UIView

+(CGFloat) viewHeight;

@property (nonatomic, weak) id<calendarSelectedProtocal> delegate;

@end
