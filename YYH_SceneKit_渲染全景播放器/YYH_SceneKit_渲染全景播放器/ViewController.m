//
//  ViewController.m
//  YYH_SceneKit_渲染全景播放器
//
//  Created by 杨昱航 on 2017/7/4.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
#import <SpriteKit/SpriteKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    SCNView * scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.scene = [SCNScene scene];
    scnView.allowsCameraControl=YES;
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 0);
    cameraNode.camera.automaticallyAdjustsZRange=YES;
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    SCNNode * panoramaNode=[SCNNode node];
    panoramaNode.geometry=[SCNSphere sphereWithRadius:100];
    [panoramaNode.geometry.firstMaterial setDoubleSided:false];
    panoramaNode.geometry.firstMaterial.cullMode=SCNCullModeFront;//全景一般照相机应该放在球体中间,我们要渲染内表面,但是默认渲染的是外表面,所以我们设置一下noramaNode.geometry?.firstMaterial?.cullMode = .front
    panoramaNode.position=SCNVector3Make(0, 0, 0);
    [scnView.scene.rootNode addChildNode:panoramaNode];
    
    
    NSURL * url=[[NSBundle mainBundle] URLForResource:@"1" withExtension:@"mp4"];
    SKVideoNode * videoNode=[SKVideoNode videoNodeWithURL:url];
    videoNode.size=CGSizeMake(1600, 900);
    videoNode.position=CGPointMake(videoNode.size.width/2, videoNode.size.height/2);
    //videoNode.zRotation=M_PI;
    SKScene * skScene=[SKScene sceneWithSize:videoNode.size];
    [skScene addChild:videoNode];
    
    panoramaNode.geometry.firstMaterial.diffuse.contents=skScene;
    [videoNode play];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
