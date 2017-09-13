//
//  ViewController.m
//  YYH_SceneKit_认识物理行为
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
    scnView.allowsCameraControl = YES;
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;    camera.automaticallyAdjustsZRange = TRUE;
    cameraNode.position = SCNVector3Make(0, 10, 10);
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    SCNBox * box=[SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0];
    SCNNode * boxNode=[SCNNode nodeWithGeometry:box];
    boxNode.physicsBody=[SCNPhysicsBody staticBody];
    boxNode.position = SCNVector3Make(0, 10, 0);
    [scnView.scene.rootNode addChildNode:boxNode];
    
    SCNNode *text1 = [self createTextNodeWithString:@"SE"];
    SCNNode *text2 = [self createTextNodeWithString:@"CE"];
    SCNNode *text3 = [self createTextNodeWithString:@"NE"];
    SCNNode *text4 = [self createTextNodeWithString:@"KT"];
    
    [scnView.scene.rootNode addChildNode:text1];
    [scnView.scene.rootNode addChildNode:text2];
    [scnView.scene.rootNode addChildNode:text3];
    [scnView.scene.rootNode addChildNode:text4];
    
    
    //创建物理行为
    SCNPhysicsHingeJoint *joint0 = [SCNPhysicsHingeJoint jointWithBodyA:boxNode.physicsBody axisA:SCNVector3Make(1, 0, 0) anchorA:SCNVector3Make(0, -0.5, 0) bodyB:text1.physicsBody axisB:SCNVector3Make(1, 0, 0) anchorB:SCNVector3Make(0.5, 1, 0)];
    SCNPhysicsHingeJoint *joint1 = [SCNPhysicsHingeJoint jointWithBodyA:text1.physicsBody axisA:SCNVector3Make(1, 0, 0) anchorA:SCNVector3Make(0, -0.5, 0) bodyB:text2.physicsBody axisB:SCNVector3Make(1, 0, 0) anchorB:SCNVector3Make(0, 0.5, 0)];
    SCNPhysicsHingeJoint *joint2 = [SCNPhysicsHingeJoint jointWithBodyA:text2.physicsBody axisA:SCNVector3Make(1, 0, 0) anchorA:SCNVector3Make(0, -0.5, 0) bodyB:text3.physicsBody axisB:SCNVector3Make(1, 0, 0) anchorB:SCNVector3Make(0, 0.5, 0)];
    SCNPhysicsHingeJoint *joint3 = [SCNPhysicsHingeJoint jointWithBodyA:text3.physicsBody axisA:SCNVector3Make(1, 0, 0) anchorA:SCNVector3Make(0, -0.5, 0) bodyB:text4.physicsBody axisB:SCNVector3Make(1, 0, 0) anchorB:SCNVector3Make(0, 0.5, 0)];
    
    // 将物理行为添加物理世界中去
    [scnView.scene.physicsWorld addBehavior:joint0];
    [scnView.scene.physicsWorld addBehavior:joint1];
    [scnView.scene.physicsWorld addBehavior:joint2];
    [scnView.scene.physicsWorld addBehavior:joint3];
}

-(SCNNode*)createTextNodeWithString:(NSString*)string{
    SCNText *text = [SCNText textWithString:string extrusionDepth:1];
    text.font = [UIFont systemFontOfSize:1];
    text.firstMaterial.diffuse.contents = @"1.jpg";
    SCNNode *node =[SCNNode nodeWithGeometry:text];
    // 创建一个物理身体,使用指定的形状
    node.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:[SCNPhysicsShape shapeWithGeometry:[SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0]options:nil]];
    
    //结合上节的效果
    SCNParticleSystem *particleSystem = [SCNParticleSystem particleSystemNamed:@"fire.scnp" inDirectory:nil];
    // 创建一个节点添加粒子系统
    SCNNode *particleNode = [SCNNode node];
    [particleNode addParticleSystem:particleSystem];
    particleNode.position = SCNVector3Make(0.5, 0, 0);
    
    [node addChildNode:particleNode];
    
    return node;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
