//
//  ViewController.m
//  YYH_SceneKit_渲染普通视频
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
    
    
    SCNView *scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.scene = [SCNScene scene];
    scnView.allowsCameraControl=YES;
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.camera.automaticallyAdjustsZRange=YES;
    [scnView.scene.rootNode addChildNode:cameraNode];

    
    SCNNode * boxNode=[SCNNode node];
    SCNPlane * plane=[SCNPlane planeWithWidth:16 height:9];
    boxNode.geometry=plane;
    [boxNode.geometry.firstMaterial setDoubleSided:YES];
    boxNode.position=SCNVector3Make(0, 0, -30);
    [scnView.scene.rootNode addChildNode:boxNode];
    
    
    NSURL * url=[[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"mp4"];
    SKVideoNode * videoNode=[SKVideoNode videoNodeWithURL:url];
    videoNode.size=CGSizeMake(1600, 900);
    videoNode.position=CGPointMake(videoNode.size.width/2, videoNode.size.height/2);
    //videoNode.zRotation=M_PI;
    SKScene * skScene=[[SKScene alloc]init];
    [skScene addChild:videoNode];
    skScene.size=videoNode.size;
    
    plane.firstMaterial.diffuse.contents=skScene;
    
    [videoNode play];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
