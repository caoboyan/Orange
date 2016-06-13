//
//  AppDelegate.m
//  Orange
//
//  Created by Aiwa on 3/21/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+EaseMob.h"

#import "LoginViewController.h"
#import "WelcomeViewController.h"

//extern"C"{
//    size_t fwrite$UNIX2003(const void *a, size_t b, size_t c, FILE *d )
//    {
//        return fwrite(a, b, c, d);
//    }
//    char* strerror$UNIX2003( int errnum )
//    {
//        return strerror(errnum);
//    }
//}


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    [[SaccountStore sharedInstance] removeCurrentAccount];
    
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    
    [self makeWelcomeController]; //this thread will finish all the functions .
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChanged:) name:@"KEY_LOGINSTATE_CHANGE" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(welconeChange:) name:@"KEY_WELCOME_MODIFY" object:nil];
    
    
    return YES;
}


-(void)remoteControlReceivedWithEvent:(UIEvent *)event{

}

////////
-(void) makeWelcomeController
{
    NSString* currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString* opendVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"KEY_SAVED_WELCOME_VER"];
    if (![currentVersion isEqualToString:opendVersion]) {
        if (self.welcomeController == nil) {
            self.welcomeController = [[WelcomeViewController alloc] init];
        }
        self.window.rootViewController = _welcomeController;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"KEY_SAVED_WELCOME_VER"];
    }else {
        [self makeLoginController];
    }
}

-(void) makeLoginController
{
    SuserModel* currentAcc = [[SaccountStore sharedInstance] getCurrentAccount];
    if (currentAcc == nil) {
        LoginViewController* login = [[LoginViewController alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = nav;
    }else {
        [self makeMainController];
    }
}

-(void) makeMainController
{
    if (!self.mainController) {
        self.mainController = [[MainController alloc] init];
    }
    self.window.rootViewController = self.mainController;
}



///jpush ...

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
    NSString* deviceTokenString = [[[deviceToken description] stringByTrimmingCharactersInSet:characterSet] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"device token ===== %@",deviceTokenString);
    
    
//    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    
    
//    [APService handleRemoteNotification:userInfo];
}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
//    if (state != UIApplicationStateActive) {
//        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(postNotify:) userInfo:userInfo repeats:NO];
//    }
//    // IOS 7 Support Required
//    [APService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}

////////// jpush over ......
- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

-(BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"open ....,%@",url);
    //    return [ShareSDK handleOpenURL:url wxDelegate:self];
    return YES;
}

-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
//    BOOL wasHandled=[[ALBBSDK sharedInstance] handleOpenURL:url];
//    //开发者继续自己处理
//    if (!wasHandled) {
//        [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//    }
    return YES;
}

-(void) welconeChange:(NSNotification*) notification
{
    NSDictionary* dict = (NSDictionary*)[notification object];
    NSString *state = [dict objectForKey:@"flag"];
    if ([state isEqualToString:@"over"]) {
        [self makeLoginController];
    }
}


-(void) loginStateChanged:(NSNotification*) notification
{
    NSDictionary* dict = (NSDictionary*)[notification object];
    NSString *isLogined = [dict objectForKey:@"flag"];
    if ([isLogined isEqualToString:@"require"]) {
        LoginViewController *loginVc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
        nav.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }else if ([isLogined isEqualToString:@"login"]) {
        [self makeMainController];
    }else if ([isLogined isEqualToString:@"logout"]){ //logout over ...
        self.mainController.selectedIndex = 0;
       // [self.mainController.tabBar.items objectAtIndex:2].badgeValue = nil;
        [[SaccountStore sharedInstance] removeCurrentAccount];
        [self makeLoginController];
    }
}



@end
