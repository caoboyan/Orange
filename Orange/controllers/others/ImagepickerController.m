//
//  ImagepickerController.m
//  Orange
//
//  Created by Aiwa on 4/26/16.
//  Copyright © 2016 Aiwa. All rights reserved.
//

#import "ImagepickerController.h"
#import <AVFoundation/AVFoundation.h>

@interface ImagepickerController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ImagepickerController
@synthesize isCamera;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!isCamera) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController* c = [[UIImagePickerController alloc] init];
            c.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            c.allowsEditing = YES;
            c.delegate=self;
            c.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:c animated:YES completion:nil];
        }
    }else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            UIImagePickerController* c = [[UIImagePickerController alloc] init];
            c.sourceType=UIImagePickerControllerSourceTypeCamera;
            c.allowsEditing = YES;
            c.delegate=self;
            c.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            c.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:c animated:YES completion:nil];
            if (status == AVAuthorizationStatusDenied) {
                UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:@"请在Iphone的“设置-隐私-相机”选项中，允许三颗糖访问您的相机" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [al show];
            }
        }
    }
}

// MARK: Photo
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    if (self.delegate != nil) {
        [self.delegate imagePicked:image];
    }
    [picker dismissViewControllerAnimated:NO completion:nil];
    [self myGoBack];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}



@end
