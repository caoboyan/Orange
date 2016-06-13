//
//  ModelActionSheet.m
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "ModelActionSheet.h"



#define ModelActionSheet_headerHeight (0)
#define ModelActionSheet_footerHeight (54)
#define ModelActionSheet_cellHeight (44)

@interface ModelActionSheet () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *tableString;
@property (nonatomic, retain) NSArray *tableIcon;
@property (nonatomic, retain) NSArray *tableColor;
@property (nonatomic, retain) NSString *tableTitle;
@property (nonatomic) NSInteger sheetIdentify;

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation ModelActionSheet

- (instancetype)initWithFrame:(CGRect)frame tableTitle:(NSString*) title Strings:(NSArray*) strings
        ICons:(NSArray*) icons Colors:(NSArray*) colors Identify:(NSInteger) identify
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableString = [NSArray arrayWithArray:strings];
        self.tableIcon = [NSArray arrayWithArray:icons];
        self.tableColor = [NSArray arrayWithArray:colors];
        self.sheetIdentify = identify;
        [self initView];
    }
    return self;
}

-(void) initView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.sframe.wbtWidth, 0) style:UITableViewStylePlain];
    NSInteger h = [self.tableString count]*ModelActionSheet_cellHeight + ModelActionSheet_headerHeight + ModelActionSheet_footerHeight;
    self.tableView.wbtHeight = h;
    [self setSframeHeight:h];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.sframe addSubview:self.tableView];
    [self show];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.tableString count];
}

//-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return ModelActionSheet_headerHeight;
//}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ModelActionSheet_footerHeight;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ModelActionSheet_cellHeight;
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sframe.wbtWidth, ModelActionSheet_footerHeight)];
    view.backgroundColor = [UIColor wbt_colorWithHexValue:0xeeeeee alpha:1];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.sframe.wbtWidth, ModelActionSheet_footerHeight-10)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"Cancel";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = ORANGE_C;
    
    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tapp];
    [view addSubview:label];
    return view;
}

//-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sframe.wbtWidth, ModelActionSheet_headerHeight)];
//    view.backgroundColor = [UIColor grayColor];
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.sframe.wbtWidth, ModelActionSheet_headerHeight-1)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor whiteColor];
//    label.text = self.tableTitle;
//    label.font = [UIFont systemFontOfSize:12];
//    label.textColor = [UIColor grayColor];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
//    label.userInteractionEnabled = YES;
//    [label addGestureRecognizer:tap];
//    [view addSubview:label];
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, label.wbtBottom-0.5, label.wbtWidth, 0.5)];
//    line.backgroundColor = [UIColor grayColor];
//    [view addSubview:line];
//    return view;
//}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate != nil) {
        [self.delegate sheetSelected:indexPath.row];
        [self.delegate sheetSelected:indexPath.row Identify:self.sheetIdentify];
    }
    [self hide];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identify = @"ActionSheetCell";
    ActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[ActionSheetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        [cell cellWidth:self.wbtWidth];
    }
    int color = 0x999999;
    if (self.tableColor != nil && [self.tableColor count] > indexPath.row) {
        color = (int)[self.tableColor objectAtIndex:indexPath.row];
    }
    [cell cellContent:[self.tableString objectAtIndex:indexPath.row]  Color:color];
    if (indexPath.row == [self.tableString count]-1) {
        [cell hideLine];
    }
    return cell;
}

-(void) hide {
    self.delegate = nil;
    [super hide];
}

@end
