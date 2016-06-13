//
//  AppDelegate.h
//  Orange
//
//  Created by Aiwa on 3/21/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewController.h"
#import "MainController.h"
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    EMConnectionState _connectionState;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MainController *mainController;
@property (nonatomic, strong) WelcomeViewController *welcomeController;

@end

