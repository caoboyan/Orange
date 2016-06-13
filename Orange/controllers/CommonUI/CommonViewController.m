//
//  CommonViewController.m
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "CommonViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"

@interface CommonViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, retain) MBProgressHUD *mbp;

@property (nonatomic, retain) UIButton *rightBtn;

@end

@implementation CommonViewController
@synthesize pageActived;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mbp = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationItem.titleView setTintColor:[UIColor whiteColor]];
    self.pageActived = YES;
}

-(void) _mbp_show:(NSString*) msg Stime:(int) time Block:(void(^)()) block
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.mbp = [MBProgressHUD showHUDAddedTo:window animated:YES];
    if (msg != nil) {
        self.mbp.mode = MBProgressHUDModeText;
        self.mbp.labelText = msg;
    }else {
        self.mbp.mode = MBProgressHUDModeIndeterminate;
    }
    self.mbp.removeFromSuperViewOnHide = YES;
    
    [self.mbp showAnimated:YES whileExecutingBlock:^{
        sleep(time);
    } completionBlock:^{
        self.mbp = nil;
        if (block != nil) {
            block();
        }
    }];
}

-(void) showLoading
{
    if (!self.pageActived || self.mbp != nil) {
        return;
    }
    [self _mbp_show:nil Stime:30 Block:nil];
}

-(void) errorMessage:(NSString*) message
{
    if (!self.pageActived || self.mbp != nil) {
        return;
    }
    [self _mbp_show:message Stime:2 Block:nil];
}

-(void) requestError:(NSError*) error
{
    if (!self.pageActived || self.mbp != nil) {
        return;
    }
    if (error != nil) {
        [self _mbp_show:error.domain Stime:2 Block:nil];
    }
}

-(void) requestSuccess:(NSString*) message Block:(void(^)()) block
{
    if (!self.pageActived || self.mbp != nil) {
        return;
    }
    [self _mbp_show:message Stime:2 Block:^{
        block();
    }];
}

-(void) hideMbp
{
    if (!self.pageActived || self.mbp == nil) {
        return;
    }
    [self.mbp hide:NO];
    self.mbp = nil;
}
-(void) rightBar3Point
{
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.rightBtn.frame = CGRectMake(0, 0, 80, 44);
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(80-23, 19, 23, 5)];
    image.image = [UIImage imageNamed:@"icon_rightnav_dot"];
    [self.rightBtn addSubview:image];
    [self.rightBtn addTarget:self action:@selector(touchedRightBar) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

-(void) setTitleText:(NSString*) text
{
    self.navigationItem.title = text;
}

-(void) touchedRightBar {}

-(void) rightBarText:(NSString*) text IsYellow:(BOOL) yellow
{
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.rightBtn.frame = CGRectMake(0, 0, 80, 44);
    [self.rightBtn setTitle:text forState:UIControlStateNormal];
    if (yellow) {
        [self.rightBtn setTitleColor:ORANGE_C forState:UIControlStateNormal];
    }else {
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [self.rightBtn addTarget:self action:@selector(touchedRightBar) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

-(void) myGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) rightBarGray
{
    [self.rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

-(void) rightBarWhite
{
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void) customLeftBar:(UIView*) view
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

-(void) activeCustomLeftBack
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.imageView.contentMode = UIViewContentModeLeft;  //;UIViewContentModeScaleAspectFill;
    [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_back_hl"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(8, 20, 130, 44);
    [btn setTintColor:[UIColor whiteColor]];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 117)];
    [btn addTarget:self action:@selector(myGoBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void) customRightBar:(UIButton*) button
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void) openTouchBackToHideKeyBoard  //如果uitableviewcell不响应，需要 shouldReceiveTouch:(UITouch *)touch
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedBaseBackView)];
    tap.delegate = self;
    tap.numberOfTouchesRequired = 1;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
}

-(void) touchedBaseBackView {}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.pageActived = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.navigationController.viewControllers count] == 1) {
        return  NO;
    }
    return YES;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.pageActived = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) leftBack
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 16, 16);
    [btn addTarget:self action:@selector(myGoBack) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

/**
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}**/


///// alert...
-(void) alertMessage:(NSString*) msg
{
    ModelAlert *ml = [[ModelAlert alloc] initWithFrame:CGRectZero Text:msg Icon:AlertTypeMessage OK:nil Cancel:nil];
}

-(void) alertError:(NSString*) msg
{
    ModelAlert *ml = [[ModelAlert alloc] initWithFrame:CGRectZero Text:msg Icon:AlertTypeError OK:nil Cancel:nil];
}

-(void) alertChoice:(NSString*) msg OK: (void (^)())ok Cancel: (void(^)()) cancel
{
    ModelAlert *ml = [[ModelAlert alloc] initWithFrame:CGRectZero Text:msg Icon:AlertTypeChoice OK:ok Cancel:cancel];
}

-(void) alertMessageWithHandler:(NSString*) msg OK :(void (^)()) ok
{
    ModelAlert *ml = [[ModelAlert alloc] initWithFrame:CGRectZero Text:msg Icon:AlertTypeMessage OK:ok Cancel:nil];
}

-(void) alertErrorWithHandler:(NSString*) msg OK :(void (^)()) ok
{
    ModelAlert *ml = [[ModelAlert alloc] initWithFrame:CGRectZero Text:msg Icon:AlertTypeError OK:ok Cancel:nil];
}

@end
