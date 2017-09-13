//
//  ViewController.m
//  YYH_SceneKit_约束的重要性
//
//  Created by 杨昱航 on 2017/6/30.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()<SCNNodeRendererDelegate>
{
    SCNView * scnView;
    SCNIKConstraint * ikConstraint;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //约束能够根据你定义的规则，自动调整这些变化(位置 旋转 和 比例)
    //SCNConstraint这个是游戏中的约束类,是一个抽象的类,我们不能直接使用,但是它有3个子类可以供我们使用。SCNLookAtConstraint,SCNTransformConstraint,SCNIKConstraint
    
    /*
     SCNIKConstraint演示过程
     1.创建一个节点链
     2.给根节点添加 SCNIKConstraint 约束对象(胳膊)
     3.添加约束給执行器(手)
     3.限定链式节点移动的范围
     4.设置目标位置,这个值可以动态的改变
     */
    
    scnView = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    //scnView.allowsCameraControl = true;
    scnView.scene = [SCNScene scene];
    scnView.scene.physicsWorld.gravity = SCNVector3Make(0, 90, 0);// 添加一个重力，我们让其方向朝上
    [self.view addSubview:scnView];
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.camera.automaticallyAdjustsZRange = true;
    cameraNode.position = SCNVector3Make(0, 0,1000);
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    //创建手掌
    SCNNode * handNode=[SCNNode node];
    handNode.geometry=[SCNBox boxWithWidth:20 height:20 length:20 chamferRadius:0];
    handNode.geometry.firstMaterial.diffuse.contents=[UIColor redColor];
    handNode.position=SCNVector3Make(0, -50, 0);
    
    //创建小臂
    SCNNode * lowerArm=[SCNNode node];
    lowerArm.geometry=[SCNCylinder cylinderWithRadius:1 height:100];;
    lowerArm.geometry.firstMaterial.diffuse.contents=[UIColor greenColor];
    lowerArm.position=SCNVector3Make(0, -50, 0);
    lowerArm.pivot=SCNMatrix4MakeTranslation(0, 50, 0);//连接点
    [lowerArm addChildNode:handNode];
    
    //创建上臂
    SCNNode * upperArm=[SCNNode node];
    upperArm.geometry=[SCNCylinder cylinderWithRadius:1 height:100];
    upperArm.geometry.firstMaterial.diffuse.contents=[UIColor yellowColor];
    upperArm.pivot=SCNMatrix4MakeTranslation(0, 50, 0);
    [upperArm addChildNode:lowerArm];
    
    
    //创建控制点
    SCNNode * controlNode=[SCNNode node];
    controlNode.geometry=[SCNSphere sphereWithRadius:10];
    controlNode.geometry.firstMaterial.diffuse.contents=[UIColor blueColor];
    [controlNode addChildNode:upperArm];
    controlNode.position=SCNVector3Make(0, 100, 0);
    
    
    [scnView.scene.rootNode addChildNode:controlNode];
    scnView.delegate=(id)self;
    
    //添加约束
    ikConstraint=[SCNIKConstraint inverseKinematicsConstraintWithChainRootNode:controlNode];
    
    
    //给执行器添加约束
    handNode.constraints=@[ikConstraint];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle)];
    [scnView addGestureRecognizer:tap];
}

-(void)tapHandle{
    [self createNodeToScene:scnView.scene andConstraint:ikConstraint];
}

-(void)createNodeToScene:(SCNScene*)scene andConstraint:(SCNIKConstraint*)ikConstrait{
    SCNNode *node = [SCNNode node];
    node.position = SCNVector3Make(arc4random_uniform(100), arc4random_uniform(100), arc4random_uniform(100));
    [scene.rootNode addChildNode:node];
    node.geometry = [SCNSphere sphereWithRadius:10];
    node.geometry.firstMaterial.diffuse.contents = [UIColor colorWithRed:arc4random_uniform(255.0)/255.0 green:arc4random_uniform(255.0)/255.0 blue:arc4random_uniform(255.0)/255.0 alpha:1];
    // 创建动画，当手掌接触到小球时,给小球添加一个动态身体
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:0.5];
    ikConstrait.targetPosition = node.position;
    [SCNTransaction commit];
    node.physicsBody = [SCNPhysicsBody dynamicBody];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
