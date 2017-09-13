//
//  ViewController.m
//  YYH_SceneKit_SCNView用法详解
//
//  Created by 杨昱航 on 2017/6/27.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1.创建游戏视图
    
    UIWindow * window=[[UIApplication sharedApplication].delegate window];
    
    SCNView * view=[[SCNView alloc]initWithFrame:window.bounds];
    [self.view addSubview:view];
    view.backgroundColor=[UIColor blackColor];
    
    //2.创建游戏场景
    SCNScene * scene=[[SCNScene alloc]init];
    view.scene=scene;
    
    //3.创建一个正方体的模型
    SCNBox * box=[[SCNBox alloc]init];
    box.width=1;
    box.height=1;
    box.chamferRadius=0;
    box.firstMaterial.diffuse.contents=@"chiImage.jpeg";
    
    //4.创建一个节点，将几何模型绑定到这个节点上
    SCNNode * boxNode=[[SCNNode alloc]init];
    boxNode.geometry=box;
    
    //5.将绑定了几何模型的节点添加到场景的根节点上去
    [scene.rootNode addChildNode:boxNode];
    
    //6.运行操作摄像机
    view.allowsCameraControl=true;
    
    //7.开启抗拒齿，如果模型出现有锯齿状的现象，你就可以使用这个属性让锯齿减弱，提高渲染性能，但是这个可能会消耗更多的手机资源，使用时还是谨慎为好。
    view.antialiasingMode=SCNAntialiasingModeMultisampling4X;
    
    
    //如何给游戏截屏
    UIImage * image=view.snapshot;
    
    //如何设置游戏的频率
    view.preferredFramesPerSecond=30;
    
    //如何打开统计菜单
    view.showsStatistics=true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
