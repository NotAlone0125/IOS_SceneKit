//
//  ViewController.m
//  YYH_SceneKit_SCNNode
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
    

    //创建游戏视图
    SCNView * scnView=[[SCNView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    scnView.center=CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    scnView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:scnView];
    
    
    //创建场景
    SCNScene * scene=[SCNScene scene];
    scnView.scene=scene;
    
    
    //添加节点
    SCNNode * node=[SCNNode node];
    [scene.rootNode addChildNode:node];
    
    
    //绑定几何物体
    SCNSphere * sphere=[SCNSphere sphereWithRadius:0.4];
    node.geometry=sphere;
    
    
    //添加子节点
    SCNNode * childNode=[SCNNode node];
    childNode.position=SCNVector3Make(0.5, 0, 1);//设置子节点的位置
    SCNText * text=[SCNText textWithString:@"SceneKit" extrusionDepth:0.05];
    text.firstMaterial.diffuse.contents=[UIColor redColor];
    text.font=[UIFont systemFontOfSize:0.15];
    childNode.geometry=text;
    [node addChildNode:childNode];
    
    
    scnView.allowsCameraControl=true;//物体可以自由旋转
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
