//
//  ImagepickerController.h
//  Orange
//
//  Created by Aiwa on 4/26/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "CommonViewController.h"

@protocol ImagePickerDelegate <NSObject>

@optional

-(void) imagePicked:(UIImage*) image;

@end

@interface ImagepickerController : CommonViewController

@property(nonatomic, weak) id<ImagePickerDelegate> delegate;

@property (nonatomic) BOOL isCamera;

@end
