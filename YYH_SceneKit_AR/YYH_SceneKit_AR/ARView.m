//
//  ARView.m
//  YYH_SceneKit_AR
//
//  Created by 杨昱航 on 2017/7/4.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ARView.h"

@implementation ARView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
        [self setUp];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        [self setUp];
    }
    return self;
}

//初始化
-(void)setUp{
    
    self.scnView=[[SCNView alloc]init];
    self.cameraNode=[SCNNode node];
    self.cameraNode.camera=[SCNCamera camera];
    self.cameraNode.camera.automaticallyAdjustsZRange=YES;
    
    [self initCamera];
    [self initScene];
    [self initMotionManger];
}

-(void)initCamera
{
    AVCaptureDevice * device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput * input=[[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    
    output=[[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    session=[[AVCaptureSession alloc]init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    if ([session canAddOutput:output])
    {
        [session addOutput:output];
    }
    
    preview=[[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    preview.videoGravity=AVLayerVideoGravityResizeAspectFill;
    preview.frame=self.bounds;
    [self.layer addSublayer:preview];
    
    [session startRunning];

}
-(void)initScene
{
    self.scnView.backgroundColor=[UIColor clearColor];
    self.scnView.frame=self.frame;
    [self addSubview:self.scnView];
    self.scnView.scene=[SCNScene scene];
    [self.scnView.scene.rootNode addChildNode:self.cameraNode];
}
-(void)initMotionManger
{
    motionManager=[[CMMotionManager alloc]init];
    motionManager.gyroUpdateInterval=60;
    motionManager.deviceMotionUpdateInterval=1/30.0;
    motionManager.showsDeviceMovementDisplay=YES;
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXMagneticNorthZVertical toQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        if(motion.attitude && error==nil)
        {
            SCNVector3 vector=SCNVector3Zero;
            if ([UIDevice currentDevice].orientation==UIDeviceOrientationPortrait)
            {
                vector.x=motion.attitude.pitch;
                vector.y=motion.attitude.roll;
            }
            else if([UIDevice currentDevice].orientation==UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation==UIDeviceOrientationLandscapeRight)
            {
                vector.x=motion.attitude.pitch;
                vector.y=motion.attitude.roll;
                
            }
            else
            {
                vector.x=motion.attitude.pitch;
                vector.y=motion.attitude.roll;
            }
            vector.z=motion.attitude.yaw;
            NSLog(@"%f--%f",vector.x,vector.y,vector.z);
            self.cameraNode.eulerAngles=vector;
        }
    }];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
}

-(void)ARViewWithModelFile:(NSURL *)fileURL position:(SCNVector3 )position
{
    SCNScene * scene=[SCNScene sceneWithURL:fileURL options:nil error:nil];
    SCNNode * node=scene.rootNode;
    node.position=position;
    [self.scnView.scene.rootNode addChildNode:node];
    
    
}
-(void)dealloc
{
    [session stopRunning];
}

@end
