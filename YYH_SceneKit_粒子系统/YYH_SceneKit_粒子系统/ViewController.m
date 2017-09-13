//
//  ViewController.m
//  YYH_SceneKit_粒子系统
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
    scnView.allowsCameraControl = TRUE;
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    camera.automaticallyAdjustsZRange=YES;
    cameraNode.position = SCNVector3Make(0, 0, 50);
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    SCNBox * box=[SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents=@"1.jpg";
    SCNNode * boxNode=[SCNNode nodeWithGeometry:box];
    boxNode.position=SCNVector3Make(0, 10, -100);
    [scnView.scene.rootNode addChildNode:boxNode];
    
    //创建例子系统，首先创建一个例子系统文件(Scenekit Particle System),选择系统自带的粒子（Fire）
    //将粒子添加到正方体上
    //1.创建例子系统对象
    SCNParticleSystem * particleSystem=[SCNParticleSystem particleSystemNamed:@"fire.scnp" inDirectory:nil];
    //2.创建一个节点添加粒子系统
    SCNNode * node=[SCNNode node];
    [node addParticleSystem:particleSystem];
    node.position=SCNVector3Make(0, -1, 0);
    //3.将粒子系统节点设置为四方体的子节点
    [boxNode addChildNode:node];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
