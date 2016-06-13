//
//  CommonLayer.m
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import "CommonLayer.h"

#define CommonLayer_bottomMargin (5.0);
#define CommonLayer_padding (5.0);

@interface CommonLayer () <UIGestureRecognizerDelegate>




@end

@implementation CommonLayer


- (CommonLayer*)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialView];
    }
    return self;
}

-(void) initialView {
    self.frame = CGRectMake(0, 0, (CGFloat)K_SCREEN_W, (CGFloat)K_SCREEN_H);
    UIWindow *root = [[[UIApplication sharedApplication] delegate] window];
    _mask = [[UIView alloc] initWithFrame:self.bounds];
    
    _mask.backgroundColor = [UIColor blackColor];
    _mask.layer.opacity = 0.3;
    _mask.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchedBack)];
    [_mask addGestureRecognizer:tap];
    [self addSubview:_mask];
    
    CGFloat p = (CGFloat)CommonLayer_padding;
    CGFloat w = (CGFloat)K_SCREEN_W - p*2;
    _sframe = [[UIView alloc] initWithFrame:CGRectMake(p, 0, w, 200)];
    _sframe.backgroundColor = [UIColor whiteColor];
    _sframe.userInteractionEnabled = YES;
    _sframe.layer.masksToBounds = YES;
    _sframe.layer.cornerRadius = 3.0;
    [self addSubview:_sframe];
    [root addSubview:self];
    [self show];
}

-(void) setSframeHeight:(CGFloat) height
{
    self.sframe.wbtHeight = height;
}

-(void) touchedBack
{
    [self hide];
}

-(void) show
{
    self.mask.alpha = 0.0f;
    self.sframe.wbtTop = (CGFloat)K_SCREEN_H;
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
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:7 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.sframe.wbtBottom = (CGFloat)K_SCREEN_H - (CGFloat)CommonLayer_bottomMargin;
    } completion:nil];
}

-(void) hide
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2];
    self.sframe.wbtTop = (CGFloat)K_SCREEN_H;
    [UIView setAnimationDidStopSelector:@selector(animHideMask)];
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
}

-(void) animHideMask
{
    self.mask.alpha = 0.3;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(destory)];
    self.mask.alpha = 0;
    [UIView commitAnimations];
    self.hidden = YES;
}

-(void) destory
{
    [self removeFromSuperview];
}


@end







