//
//  ViewController.m
//  YYH_SceneKit_SCNPhysicsWorld作用介绍
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
    
    //输出场景中的重力加速度，可以设置大小和方向(默认有一个向下的重力，如过都设置为0，场景中所有物体都会失重)
    NSLog(@"x:%f",scnView.scene.physicsWorld.gravity.x);
    NSLog(@"y:%f",scnView.scene.physicsWorld.gravity.y);
    NSLog(@"z:%f",scnView.scene.physicsWorld.gravity.z);
    
    /*
     物理世界对象主要干那些事情:
     
     控制全局属性 (比如重力和其他类型的力 还有它的速度)
     间接修改或者注册场景中的物理身体的连接等行为
     管理物理身体的碰撞行为
     执行特殊的接触测试(如发射,扫射)
     本节内容先了解一下,后面我们有详解的章节,对各个方法进行讲解!
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
