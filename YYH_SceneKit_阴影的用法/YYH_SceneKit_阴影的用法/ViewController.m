//
//  ViewController.m
//  YYH_SceneKit_阴影的用法
//
//  Created by 杨昱航 on 2017/7/3.
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
    scnView.allowsCameraControl=YES;
    
    SCNCamera *camera = [SCNCamera camera];
    camera.automaticallyAdjustsZRange=YES;
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 1000, 1000);
    cameraNode.rotation=SCNVector4Make(1, 0, 0, -M_PI/4);
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    
    //创建一个聚光灯
    SCNCone * cone=[SCNCone coneWithTopRadius:1 bottomRadius:25 height:50];
    cone.radialSegmentCount=10;
    cone.heightSegmentCount=5;
    //创建一个灯节点
    SCNNode * spotlight=[SCNNode nodeWithGeometry:cone];
    spotlight.geometry.firstMaterial.emission.contents=[UIColor yellowColor];
    spotlight.position=SCNVector3Make(0, 0, 0);
    spotlight.light=[SCNLight light];
    spotlight.light.type=SCNLightTypeSpot;
    spotlight.light.castsShadow=YES;
    spotlight.light.shadowMode=SCNShadowModeForward;
    spotlight.light.spotOuterAngle=60;
    spotlight.light.zFar=2000;//因为灯光的最远注意默认值为100 ,由于我们将灯的指点放在1000 灯光照射不到那个距离,所以我们需要调节灯光照射的最远距离
    //创建一个支点，放光源
    SCNNode * handleNode=[SCNNode node];
    handleNode.position=SCNVector3Make(0, 1000, 40);
    [handleNode addChildNode:spotlight];
    [scnView.scene.rootNode addChildNode:handleNode];
    
    
    //给灯光支点添加移动行为
    SCNAction * moveRight=[SCNAction moveTo:SCNVector3Make(100, 1000, 40) duration:2];
    SCNAction * moveLeft=[SCNAction moveTo:SCNVector3Make(-100, 1000, 40) duration:2];
    SCNAction * sequece=[SCNAction sequence:@[moveRight,moveLeft]];
    [handleNode runAction:[SCNAction repeatActionForever:sequece]];
    
    //添加地板，显示阴影
    SCNFloor * floor=[SCNFloor floor];
    floor.firstMaterial.diffuse.contents=@"1.png";
    SCNNode * floorNode=[SCNNode nodeWithGeometry:floor];
    [scnView.scene.rootNode addChildNode:floorNode];
    
    //添加模型
    SCNScene * scene=[SCNScene sceneNamed:@"palm_tree.dae"];
    SCNNode * modelNode=[scene.rootNode childNodeWithName:@"PalmTree" recursively:YES];
    modelNode.rotation=SCNVector4Make(1, 0, 0, -M_PI);
    [scnView.scene.rootNode addChildNode:modelNode];
    
    SCNConstraint * constaint=[SCNLookAtConstraint lookAtConstraintWithTarget:modelNode];
    spotlight.constraints=@[constaint];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
