//
//  ModelPicker.h
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "CommonLayer.h"

@protocol ModelPickerDelegare <NSObject>

@optional
-(void) customPickerOkPressed:(NSInteger) row Component:(NSInteger) component;
-(void) customPickerValueChanged:(NSInteger) row Component:(NSInteger) component;

@end

@interface ModelPicker : CommonLayer

@property (nonatomic,weak) id<ModelPickerDelegare> delegate;
@property (nonatomic, retain) NSMutableArray *pickerData;

-(void) resetData:(NSArray*) data;
-(void) setupSelectedComponent;

@end
