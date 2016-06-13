//
//  AppDelegate+EaseMob.m
//  Candy2
//
//  Created by Aiwa on 11/3/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "AppDelegate+EaseMob.h"

@implementation AppDelegate (EaseMob)

-(void) easemobApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (launchOptions) {
        NSDictionary *userInfo =[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo) {
            [self didReceiveRemoteNotification:userInfo];
        }
    }
    _connectionState = EMConnectionConnected;
    
    EMOptions* options = [EMOptions optionsWithAppkey:EASEMOB_APPKEY];
    options.apnsCertName = EASEMOB_CERNAME;
    if (K_EASEMOB_DEBUG == YES) {
        options.logLevel = EMLogLevelDebug;
        options.enableConsoleLog = YES;
    }
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [self registerRemoteNotification];
    
    [self setupNotifiers];
    
}

// 注册推送
- (void)registerRemoteNotification{
    UIApplication *application = [UIApplication sharedApplication];
    application.applicationIconBadgeNumber = 0;
    
#if !TARGET_IPHONE_SIMULATOR
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
#endif
}

// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)setupNotifiers{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackgroundNotif:)
          name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:)
           name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActiveNotif:)
           name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActiveNotif:)
            name:UIApplicationWillResignActiveNotification object:nil];
}

#pragma mark - notifiers
- (void)appDidEnterBackgroundNotif:(NSNotification*)notif{
    [[EMClient sharedClient] applicationDidEnterBackground:notif.object];
}

- (void)appWillEnterForeground:(NSNotification*)notif
{
    [[EMClient sharedClient] applicationWillEnterForeground:notif.object];
}


- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSString* deviceTokenString = [[[deviceToken description] stringByTrimmingCharactersInSet:characterSet] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"device token ===== %@",deviceTokenString);
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
    
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns) message:error.description delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil];
    [alert show];
}

// 网络状态变化回调
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    _connectionState = connectionState;
#warning todo....
    //[self.mainController networkChanged:connectionState];
}

// 打印收到的apns信息
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
}



-(BOOL)canBecomeFirstResponder{
    return YES;
}






@end
