//
//  MyEventsController.m
//  Orange
//
//  Created by Aiwas on 5/8/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "MyEventsController.h"
#import "EventRecommendCell.h"
#import "SeventEngine.h"
#import "SaccountStore.h"

@interface MyEventsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataList;

@end

@implementation MyEventsController

@synthesize eventType;
// 1.create event 2.up coming event 3.past event 4.liked event

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSMutableArray alloc]init];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customTableview];
    
    if (eventType == 3) {
        [self requestLikeEvent];
    }
}

- (void)requestLikeEvent{
    SeventEngine * engine = [[SeventEngine alloc]init];
 
    [engine getUserTreasureList:[[[SaccountStore sharedInstance]getCurrentUid] integerValue] PageSize:10 PageNum:0 Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            
        }else{
            NSLog(@"好像失败了，那就显示空白页面吧");
        }
    }];
}

- (void)customTableview{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[EventRecommendCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventRecommendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[EventRecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

@end
