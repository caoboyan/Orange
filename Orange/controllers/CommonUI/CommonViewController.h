//
//  CommonViewController.h
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController

@property (nonatomic) BOOL pageActived;

-(void) showLoading;

-(void) errorMessage:(NSString*) message;

-(void) requestError:(NSError*) error;

-(void) requestSuccess:(NSString*) message Block:(void(^)()) block;

-(void) hideMbp;

-(void) rightBar3Point;

-(void) setTitleText:(NSString*) text;

-(void) touchedRightBar;

-(void) rightBarText:(NSString*) text IsYellow:(BOOL) yellow;

-(void) myGoBack;

-(void) leftBack;

-(void) activeCustomLeftBack;

-(void) rightBarGray;

-(void) rightBarWhite;

-(void) customLeftBar:(UIView*) view;

-(void) customRightBar:(UIButton*) button;

-(void) openTouchBackToHideKeyBoard;

-(void) touchedBaseBackView;

///// alert...
-(void) alertMessage:(NSString*) msg;

-(void) alertError:(NSString*) msg;

-(void) alertChoice:(NSString*) msg OK: (void (^)())ok Cancel: (void(^)()) cancel;

-(void) alertMessageWithHandler:(NSString*) msg OK :(void (^)()) ok;

-(void) alertErrorWithHandler:(NSString*) msg OK :(void (^)()) ok;





@end
