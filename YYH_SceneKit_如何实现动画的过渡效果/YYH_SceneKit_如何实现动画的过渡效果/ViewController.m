//
//  ViewController.m
//  YYH_SceneKit_如何实现动画的过渡效果
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
    
    SCNView *scnView = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.scene = [SCNScene scene];
    scnView.allowsCameraControl = true;
    [self.view addSubview:scnView];
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.position = SCNVector3Make(0, 0, 20);
    cameraNode.camera = [SCNCamera camera];
    cameraNode.camera.automaticallyAdjustsZRange = true;
    [scnView.scene.rootNode addChildNode:cameraNode];

    
    NSURL *url1 = [[NSBundle mainBundle]URLForResource:@"aaa" withExtension:@"dae"];
    NSURL *url2 = [[NSBundle mainBundle]URLForResource:@"aaa2" withExtension:@"dae"];
    SCNScene *scene1 = [SCNScene sceneWithURL:url1 options:nil error:nil];
    SCNScene *scene2 = [SCNScene sceneWithURL:url2 options:nil error:nil];
    SCNGeometry *g1 = [scene1.rootNode childNodeWithName:@"plane" recursively:true].geometry;
    SCNGeometry *g2 = [scene2.rootNode childNodeWithName:@"plane" recursively:true].geometry;
    g1.firstMaterial.diffuse.contents=@"mapImage";
    g2.firstMaterial.diffuse.contents=@"mapImage";
    
    
    //将第一个几何体绑定到节点上添加到场景
    SCNNode * planeNode=[SCNNode node];
    planeNode.geometry=g1;
    [scnView.scene.rootNode addChildNode:planeNode];
    
    
    
    //下面是主要内容
    //创建一个过渡期，添加我们要过渡的模型
    planeNode.morpher=[[SCNMorpher alloc]init];
    planeNode.morpher.targets=@[g2];
    
    //设置过渡动画
    CABasicAnimation * animation=[CABasicAnimation animationWithKeyPath:@"morpher.weights[0]"];//0代表过渡目标数组中的第一个模型
    animation.fromValue=@0.0;
    animation.toValue=@1.0;
    animation.autoreverses=YES;
    animation.repeatCount=INFINITY;
    animation.duration=10;
    [planeNode addAnimation:animation forKey:nil];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
