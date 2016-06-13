//
//  ModelActionSheet.h
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "CommonLayer.h"
#import "ActionSheetCell.h"


@protocol ModelActionSheetSelectedDelegate <NSObject>

@optional

-(void) sheetSelected:(NSInteger) row;
-(void) sheetSelected:(NSInteger) row Identify:(NSInteger) identify;

@end

@interface ModelActionSheet : CommonLayer
@property(nonatomic,weak) id<ModelActionSheetSelectedDelegate> delegate;




- (instancetype)initWithFrame:(CGRect)frame tableTitle:(NSString*) title Strings:(NSArray*) strings
        ICons:(NSArray*) icons Colors:(NSArray*) colors Identify:(NSInteger) identify;

@end
