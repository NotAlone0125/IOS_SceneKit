//
//  ViewController.m
//  YYH_SceneKit_游戏中的物理身体
//
//  Created by 杨昱航 on 2017/6/29.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    SCNView *scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.scene = [SCNScene scene];
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 5);
    [scnView.scene.rootNode addChildNode:cameraNode];

    
    SCNSphere *sphere = [SCNSphere sphereWithRadius:1];
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    [scnView.scene.rootNode addChildNode:sphereNode];

    
    //创建物理身体
    //sphereNode.physicsBody=[SCNPhysicsBody staticBody];
    //sphereNode.physicsBody=[SCNPhysicsBody dynamicBody];
    sphereNode.physicsBody=[SCNPhysicsBody kinematicBody];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
