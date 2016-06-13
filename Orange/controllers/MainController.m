//
//  MainController.m
//  Sword
//
//  Created by Aiwa on 12/14/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "MainController.h"
#import "SuserEngine.h"

#import "EventsIndexController.h"
#import "DiscoverIndexController.h"
#import "CreateIndexController.h"
#import "MessageIndexController.h"
#import "ProfileIndexController.h"

#import <QuartzCore/QuartzCore.h>

@interface MainController ()

@end

@implementation MainController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    EventsIndexController* eventsCtrl = [[EventsIndexController alloc] init];
    DiscoverIndexController* discoverCtrl = [[DiscoverIndexController alloc] init];
    CreateIndexController* createCtrl = [[CreateIndexController alloc] init];
    MessageIndexController* messageCtrl = [[MessageIndexController alloc] init];
    ProfileIndexController* profileCtrl = [[ProfileIndexController alloc] init];
    

    
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:eventsCtrl];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:discoverCtrl];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:createCtrl];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:messageCtrl];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:profileCtrl];
    
    UIImage* tabbarImage0 = [[UIImage imageNamed:@"tab_events"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarImage1 = [[UIImage imageNamed:@"tab_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarImage2 = [[UIImage imageNamed:@"tab_create"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarImage3 = [[UIImage imageNamed:@"tab_messages"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarImage4 = [[UIImage imageNamed:@"tab_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage* tabbarSelImage0 = [[UIImage imageNamed:@"tab_events_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarSelImage1 = [[UIImage imageNamed:@"tab_discover_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarSelImage2 = [[UIImage imageNamed:@"tab_create_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarSelImage3 = [[UIImage imageNamed:@"tab_messages_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* tabbarSelImage4 = [[UIImage imageNamed:@"tab_profile_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabbarItem0 = [[UITabBarItem alloc] initWithTitle:@"Events" image:tabbarImage0 selectedImage:tabbarSelImage0];
    UITabBarItem *tabbarItem1 = [[UITabBarItem alloc] initWithTitle:@"Discover" image:tabbarImage1 selectedImage:tabbarSelImage1];
    UITabBarItem *tabbarItem2 = [[UITabBarItem alloc] initWithTitle:@"" image:tabbarImage2 selectedImage:tabbarSelImage2];
    UITabBarItem *tabbarItem3 = [[UITabBarItem alloc] initWithTitle:@"Message" image:tabbarImage3 selectedImage:tabbarSelImage3];
    UITabBarItem *tabbarItem4 = [[UITabBarItem alloc] initWithTitle:@"Profile" image:tabbarImage4 selectedImage:tabbarSelImage4];
    
    nav0.tabBarItem = tabbarItem0;
    nav1.tabBarItem = tabbarItem1;
    nav2.tabBarItem = tabbarItem2;
    nav3.tabBarItem = tabbarItem3;
    nav4.tabBarItem = tabbarItem4;
    
    UIColor* normalColor = [UIColor wbt_colorWithHexValue:0xb2b7c1 alpha:1];
    UIColor* selectColor = ORANGE_C;
    
    [tabbarItem0 setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
    [tabbarItem0 setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor} forState:UIControlStateSelected];
    [tabbarItem1 setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
    [tabbarItem1 setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor} forState:UIControlStateSelected];
    [tabbarItem2 setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
    [tabbarItem2 setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor} forState:UIControlStateSelected];
    [tabbarItem3 setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
    [tabbarItem3 setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor} forState:UIControlStateSelected];
    [tabbarItem4 setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor} forState:UIControlStateNormal];
    [tabbarItem4 setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor} forState:UIControlStateSelected];
    self.viewControllers = @[nav0,nav1,nav2,nav3,nav4];
    
    
//    self.tabBar.backgroundImage = [UIImage imageFromColor:ORANGE_C];
//    self.tabBar.tintColor = ORANGE_C;
    [self.tabBar setShadowImage:[UIImage imageFromColor:ORANGE_C]];
    [self.tabBar setBackgroundImage:[[UIImage alloc] init]];


}


-(void) loginEasemob
{
    [[EMClient sharedClient] logout:YES];
    EMError *error = [[EMClient sharedClient] loginWithUsername:@"26" password:@"111111"];
    if (!error) {
        NSLog(@"登陆成功");
        NSArray* arr = [[EMClient sharedClient].contactManager getContactsFromServerWithError:nil];
        NSArray *myGroups = [[EMClient sharedClient].groupManager getMyGroupsFromServerWithError:&error];
        [self setUnread];
    }else {
        //notification
        //删除login 信息
    }
}

-(void) setUnread
{
    NSArray* arr = [[EMClient sharedClient].groupManager getAllGroups];
    int unreadCount = 0;
    for (EMGroup* group in arr) {
        EMConversation *conv = [[EMClient sharedClient].chatManager getConversation:group.groupId type:EMConversationTypeGroupChat createIfNotExist:YES];
        unreadCount += conv.unreadMessagesCount;
    }
    NSArray* arr2 = [[EMClient sharedClient].contactManager getContacts];
    for (NSString* contact in arr2) {
        EMConversation* conv = [[EMClient sharedClient].chatManager getConversation:contact type:EMConversationTypeChat createIfNotExist:YES];
        unreadCount += conv.unreadMessagesCount;
    }
    
    //    UITabBarItem *tabbarItem = [self.tabBar.items objectAtIndex:2];
    //    if (unreadCount > 0) {
    //        tabbarItem.badgeValue = [NSString stringWithFormat:@"%ld", unreadCount];
    //    }else {
    //        tabbarItem.badgeValue = nil;
    //    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
}

/**
-(void) goPerson
{
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"1" conversationType:EMConversationTypeChat];
    [self.navigationController pushViewController:chatController animated:YES];
}


-(void) goGropu
{
    // id : 171474346072605124
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"184825862976176560" conversationType:EMConversationTypeGroupChat];
    [self.navigationController pushViewController:chatController animated:YES];
}
**/



@end
