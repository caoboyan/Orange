//
//  ModelPicker.m
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "ModelPicker.h"

@interface ModelPicker() <UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, retain) NSMutableArray *selectedArray;
@property (nonatomic, retain) NSMutableArray *selectedRowOfComponent;

@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger component;

@property (nonatomic, retain) UIPickerView *picker;

@end

@implementation ModelPicker

@synthesize delegate, pickerData;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerData = [[NSMutableArray alloc] init];
        self.selectedArray = [[NSMutableArray alloc] init];
        self.selectedRowOfComponent = [[NSMutableArray alloc] init];
        [self initView];
    }
    return self;
}

-(void) initView
{   //header
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sframe.wbtWidth, 44)];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCancel.frame = CGRectMake(0, 0, 80, 44);
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(touchedBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnOk = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnOk.frame = CGRectMake(self.sframe.wbtWidth-80, 0, 80, 44);
    [btnOk setTitle:@"OK" forState:UIControlStateNormal];
    [btnOk addTarget:self action:@selector(toucheOk) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btnCancel];
    [header addSubview:btnOk];
    
    [self.sframe addSubview:header];
    //views
    self.picker = [[UIPickerView alloc] init];
    self.picker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.picker.frame = CGRectMake(5, 44, self.sframe.wbtWidth-10, 162);
    self.picker.delegate = self;
    self.picker.dataSource = self;
    [self.sframe addSubview:self.picker];
    [self setSframeHeight:self.picker.wbtBottom];
}

-(UIView*) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 13)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 10)];
        label.tag = 2001;
        [view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:17];
    }
    UILabel *label = [view viewWithTag:2001];
    label.text = [[self.pickerData objectAtIndex:component] objectAtIndex:row];
    [label sizeToFit];
    view.frame = label.bounds;
    return view;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData[component] count];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return [self.pickerData count];
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.row = row;
    self.component = component;
    if (self.delegate != nil) {
        [self.delegate customPickerValueChanged:row Component:component];
    }
}

-(void) toucheOk
{
    if (self.delegate != nil) {
        [self.delegate customPickerOkPressed:self.row Component:self.component];
    }
    [self hide];
}

-(void) resetData:(NSArray*) data
{
    self.pickerData = [NSMutableArray arrayWithArray:data];
    NSArray* timeArray = [data objectAtIndex:1];
    if ([timeArray count] > 0) {
        [self.picker reloadComponent:1];
    }else {
        [self.picker reloadAllComponents];
    }
}

-(void) setupSelectedComponent
{
    if (self.selectedRowOfComponent != nil && [self.selectedRowOfComponent count] > 0) {
        for (NSDictionary *comt in self.selectedRowOfComponent) {
            NSInteger row = [[comt objectForKey:@"row"] intValue];
            NSInteger component = [[comt objectForKey:@"component"] intValue];
            [self.picker selectRow:row inComponent:component animated:YES];
        }
    }
}



@end












