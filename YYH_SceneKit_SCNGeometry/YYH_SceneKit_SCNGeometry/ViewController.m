//
//  ViewController.m
//  YYH_SceneKit_SCNGeometry
//
//  Created by 杨昱航 on 2017/6/27.
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
    [self.view addSubview:scnView];
    scnView.allowsCameraControl = TRUE;

    
    scnView.scene = [SCNScene scene];

    
    SCNNode *cameraNode =[SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0, 0, 5);
    [scnView.scene.rootNode addChildNode:cameraNode];

    //正方体(chamferRadius,有切面的正方体)
    SCNBox * box=[SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0.5];
    box.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
    SCNNode * boxNode=[SCNNode node];
    boxNode.position=SCNVector3Make(0, 0, 0);
    boxNode.geometry=box;
    [scnView.scene.rootNode addChildNode:boxNode];
    
    //SegmentCount属性作用演示（结合SCNBox）,对正方体的表面进行切割
    box.chamferSegmentCount=20;
    
    
    //平面
//    SCNPlane * plane=[SCNPlane planeWithWidth:2 height:2];
//    plane.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * planeNode=[SCNNode nodeWithGeometry:plane];
//    planeNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:planeNode];
    
    
    //金字塔
//    SCNPyramid * pyramid=[SCNPyramid pyramidWithWidth:1 height:1 length:1];
//    pyramid.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * pyramidNode=[SCNNode nodeWithGeometry:pyramid];
//    pyramidNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:pyramidNode];
    
    
    //球体
//    SCNSphere * sphere=[SCNSphere sphereWithRadius:0.5];
//    sphere.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * sphereNode=[SCNNode nodeWithGeometry:sphere];
//    sphereNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:sphereNode];
    
    //圆柱体
//    SCNCylinder * cylinder=[SCNCylinder cylinderWithRadius:1 height:2];
//    cylinder.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * cylinderNode=[SCNNode nodeWithGeometry:cylinder];
//    cylinderNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:cylinderNode];
    
    
    //圆锥体
//    SCNCone * cone=[SCNCone coneWithTopRadius:0.1 bottomRadius:1 height:2];
//    cone.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * coneNode=[SCNNode nodeWithGeometry:cone];
//    coneNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:coneNode];
    
    
    //管道
//    SCNTube * tube=[SCNTube tubeWithInnerRadius:1 outerRadius:1.2 height:2];
//    tube.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * tubeNode=[SCNNode nodeWithGeometry:tube];
//    tubeNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:tubeNode];
    

    //环面
//    SCNTorus *torus = [SCNTorus torusWithRingRadius:1 pipeRadius:0.5];
//    torus.firstMaterial.diffuse.contents = [UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode *torusNode = [SCNNode nodeWithGeometry:torus];
//    torusNode.position = SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:torusNode];
    
    
    //地板
//    SCNFloor * floor=[SCNFloor floor];
//    floor.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * floorNode=[SCNNode nodeWithGeometry:floor];
//    floorNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:floorNode];
//    
    
    //立体文字
//    SCNText * text=[SCNText textWithString:@"哈哈哈哈" extrusionDepth:0.5];
//    text.font=[UIFont systemFontOfSize:18];
//    text.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * textNode=[SCNNode nodeWithGeometry:text];
//    textNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:textNode];
    
    
    //自定义形状,定义贝塞尔曲线
//    SCNShape * shape=[SCNShape shapeWithPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 1, 1) cornerRadius:0.5]  extrusionDepth:3];
//    shape.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
//    SCNNode * shapeNode=[SCNNode nodeWithGeometry:shape];
//    shapeNode.position=SCNVector3Make(0, 0, 0);
//    [scnView.scene.rootNode addChildNode:shapeNode];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
