//
//  MessageIndexController.m
//  Orange
//
//  Created by Aiwa on 3/22/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "MessageIndexController.h"

#import "MessageFriendCell.h"
#import "MessageGroupCell.h"

#import "SuserEngine.h"
#import "EaseMessageViewController.h"




/**
typedef NS_ENUM(NSInteger, MessageCurrentList) {
    MessageCurrentListFriend = 0,
    MessageCurrentListGroup = 1
};
 **/

@interface MessageIndexController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _segmengTag;
    UITableView* _tableView;
    
    NSArray* _friendArray;
    NSArray* _groupArray;
}
@end

@implementation MessageIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _segmengTag = 0;
    _friendArray = [NSArray array];
    _groupArray = [NSArray array];
    [self initViews];
    [self getFriendList];
}

-(void) initViews
{
    UISegmentedControl * segmented = [[UISegmentedControl alloc] initWithItems:@[@"Friends", @"Group"]];
    segmented.frame = CGRectMake(0, 0, 160, 30);
    segmented.selectedSegmentIndex = _segmengTag; //设置默认选中项
    segmented.tintColor = ORANGE_C;
    [segmented addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged]; //添加事件
//    [self.view addSubview:segmented];
    self.navigationItem.titleView = segmented;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_W, K_SCREEN_H-113)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void) segmentedAction:(id)sender {
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl * segment = sender;
        _segmengTag = segment.selectedSegmentIndex;
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* arr = _segmengTag == 0 ? _friendArray : _groupArray;
    return  [arr count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segmengTag == 0) {
        return [MessageFriendCell cellHeight];
    }
    return [MessageGroupCell cellHeight];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segmengTag == 0) { // friends
        SmessageFriend* model = [_friendArray objectAtIndex:indexPath.row];
        MessageFriendCell* cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell"];
        if (cell == nil) {
            cell = [[MessageFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"friendCell"];
        }
        
        [cell cellContent:model];
        return cell;
    }
    
    return nil; //123123
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_segmengTag == 0) { // friends
        SmessageFriend* model = [_friendArray objectAtIndex:indexPath.row];
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:model.UID conversationType:EMConversationTypeChat];
        [self.navigationController pushViewController:chatController animated:YES];
    }else {
        SmessageGroup* model = [_groupArray objectAtIndex:indexPath.row];
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:model.GID conversationType:EMConversationTypeGroupChat];
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

#pragma mark ====== deal data
-(void) getFriendList
{
    NSString* currentUid = [[SaccountStore sharedInstance] getCurrentUid];
    SuserEngine* engine = [[SuserEngine alloc] init];
    [engine friendList:@"0" Uid:currentUid PageSize:10 PageNum:1 Encrypt:@"n" Extra:nil completeHandler:^(id data, BOOL success, NSError *error) {
        if (success) {
            NSArray* dataArr = (NSArray*) data;
            NSMutableArray* muarr = [NSMutableArray array];
            for (SmessageFriend* model in dataArr) {
                EMConversation* conversation = [[EMClient sharedClient].chatManager getConversation:model.UID type:EMConversationTypeChat createIfNotExist:YES];
                model.detailMsg = [self subTitleMessageByConversation:conversation];
                model.time = [self lastMessageTimeByConversation:conversation];
                model.unreadCount = [self unreadMessageCountByConversation:conversation];
                [muarr addObject:model];
            }
            _friendArray = [NSArray arrayWithArray:muarr];
            [_tableView reloadData];
        }
    }];
}
-(void) getGroupList
{
    
    ///
    [_tableView reloadData];
}

#pragma mark ===== chatter infos from easemob

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        //        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
        NSDate *date = [NSDate dateWithTimeIntervalInMilliSecondSince1970:lastMessage.timestamp];
        ret = [StringUtil calendarDate:date];
    }
    return ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        EMMessageBody* messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                ret = @"[图片]";
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                ret = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                ret = @"[音频]";
            } break;
            default: {
            } break;
        }
    }
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    return  ret;
}


@end
