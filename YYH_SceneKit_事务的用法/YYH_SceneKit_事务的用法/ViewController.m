//
//  ViewController.m
//  YYH_SceneKit_事务的用法
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
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 50);
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    SCNSphere *sphere = [SCNSphere sphereWithRadius:1];
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    sphereNode.position=SCNVector3Make(0, 0, 0);
    [scnView.scene.rootNode addChildNode:sphereNode];
    
    
    //方式一
//    [SCNTransaction setAnimationDuration:5];
//    sphereNode.position=SCNVector3Make(3, 3, 3);
    
    //方式二
    [SCNTransaction begin];
    [SCNTransaction setAnimationDuration:2];
    [SCNTransaction setCompletionBlock:^{
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:1];
        sphereNode.geometry.firstMaterial.diffuse.contents=[UIColor redColor];
        [SCNTransaction commit];
    }];
    sphereNode.geometry.firstMaterial.diffuse.contents=[UIColor yellowColor];
    [SCNTransaction commit];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
