//
//  CommonLayer.h
//  Candy2
//
//  Created by Aiwa on 10/30/15.
//  Copyright © 2015 Aiwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonLayer : UIView

@property (nonatomic, retain) UIView* mask;
@property (nonatomic, retain) UIView* sframe;


- (CommonLayer*)initWithFrame:(CGRect)frame;

-(void) setSframeHeight:(CGFloat) height;

-(void) show;
-(void) hide;
-(void) aniShowFrame;

-(void) animHideMask;
-(void) destory;
-(void) touchedBack;

@end



