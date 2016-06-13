//
//  ModelAlert.m
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "ModelAlert.h"

#define ModelAlert_padding (50.0)

@interface ModelAlert()


@property (nonatomic, retain) NSString* stitle;
@property (nonatomic, assign) AlertType icon;

@property (nonatomic, copy) void (^okHandler)();
@property (nonatomic, copy) void (^cancelHandler)();

@end

@implementation ModelAlert
- (instancetype)initWithFrame:(CGRect)frame
        Text:(NSString*) text
        Icon:(AlertType) icon
        OK: (void (^)())ok
        Cancel: (void(^)()) cancel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.stitle = text;
        self.icon = icon;
        self.okHandler = ok;
        self.cancelHandler = cancel;
        [self initView];
    }
    return self;
}

-(void) initView
{
    self.sframe.frame = CGRectMake((CGFloat)ModelAlert_padding, 0, (CGFloat)K_SCREEN_W-(CGFloat)ModelAlert_padding*2, 200);
    self.sframe.layer.masksToBounds = YES;
    self.sframe.layer.cornerRadius = 5.0f;
    
    CGFloat sw = self.sframe.wbtWidth;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(sw/2-65, 20, 129, 30)];
    NSArray *imageArray = @[@"orange_logo",@"orange_logo",@"orange_logo"];
    image.image = [UIImage imageNamed:[imageArray objectAtIndex:self.icon]];
    [self.sframe addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, image.wbtBottom + 10, sw-40, 40)];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.stitle;
    [self.sframe addSubview:label];
    
    if (self.icon == AlertTypeChoice) {
        UIButton* cancelBtn = [UiUtil get_button:@"Cancel" Full:YES Blue:NO];
        cancelBtn.frame = CGRectMake(0, label.wbtBottom+10, sw/2, 44);
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor darkGrayColor];
        [cancelBtn addTarget:self action:@selector(touchCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.sframe addSubview:cancelBtn];
    }
    UIButton *okBtn = [UiUtil get_button:@"OK" Full:YES Blue:YES];
    [okBtn setBackgroundColor:ORANGE_C];
    okBtn.frame = CGRectMake(0, label.wbtBottom+10, sw, 44);
    if (self.icon == AlertTypeChoice) {
        okBtn.frame = CGRectMake(sw/2, label.wbtBottom+10, sw/2, 44);
    }
    [okBtn addTarget:self action:@selector(touchOk) forControlEvents:UIControlEventTouchUpInside];
    [self.sframe addSubview:okBtn];
    [self setSframeHeight:okBtn.wbtBottom];
}

#pragma mark == override
-(void) show
{
    self.mask.alpha = 0.0;
    self.sframe.wbtBottom = 0;
    self.sframe.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(aniShowFrame)];
    self.mask.alpha = 0.3;
    [UIView commitAnimations];
}

-(void) aniShowFrame
{
    self.sframe.hidden = NO;
    CGFloat h = K_SCREEN_H/2 - self.sframe.wbtHeight/2;
    self.sframe.wbtBottom = 0;
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.sframe.wbtTop = h;
    } completion:nil];
}

-(void) touchOk
{
    if (self.okHandler != nil) {
        self.okHandler();
    }
    [self hide];
}

-(void) touchCancel
{
    if (self.cancelHandler != nil) {
        self.cancelHandler();
    }
    [self hide];
}



@end
