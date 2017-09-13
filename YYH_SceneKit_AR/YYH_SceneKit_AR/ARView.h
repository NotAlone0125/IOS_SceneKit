//
//  ARView.h
//  YYH_SceneKit_AR
//
//  Created by 杨昱航 on 2017/7/4.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

@interface ARView : UIView<AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AVCaptureSession * session;
    AVCaptureVideoPreviewLayer * preview;
    AVCaptureMetadataOutput * output;
    CMMotionManager * motionManager;
    UIInterfaceOrientation * orientation;
    
}
@property(nonatomic,strong)SCNView * scnView;
@property(nonatomic,strong)SCNNode * cameraNode;

@property id  ARViewDelegate;
-(void)ARViewWithModelFile:(NSURL *)fileURL position:(SCNVector3 )position;
-(id)initWithFrame:(CGRect)frame;

@end

//@protocol DoctorScreenViewDelegate <NSObject>
//
//@optional

//@required
//
//@end
