//
//  ViewController.m
//  YYH_SceneKit_SCNView的重要性
//
//  Created by 杨昱航 on 2017/6/30.
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
    scnView.allowsCameraControl=YES;
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 5);
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    SCNSphere *sphere = [SCNSphere sphereWithRadius:1];
    sphere.firstMaterial.diffuse.contents=@"chiImage.jpeg";
    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    [scnView.scene.rootNode addChildNode:sphereNode];
    
    //打开调试模式。查看我们的帧率和场景中包含多少个精灵
    scnView.showsStatistics=YES;
    
    //调节渲染的频率,当画面能满足我们的画质要求和性能要求的时候，尽量吧帧率设置低点，能够节省CPU资源
    scnView.preferredFramesPerSecond=30;
    
    //截屏
    [scnView snapshot];
    
    //查看游戏的引擎类型
    if (scnView.eaglContext)
    {
        NSLog(@"OpenGL");
    }
    else
    {
        NSLog(@"Metal");
    }
    
    //如何改善画面质量，开启抗锯齿功能，默认是关闭的
    scnView.antialiasingMode=SCNAntialiasingModeMultisampling4X;
    
    
    //选择渲染模式，应该按如下方法初始化SCNView
    
    //(OpenGL+Metal)
    SCNView * _scnView  = [[SCNView alloc]initWithFrame:self.view.bounds options:@{SCNPreferLowPowerDeviceKey:@(true)}];
    //OpenGL:SCNPreferredRenderingAPIKey
    //指定渲染器使用<MTLDevice>:SCNPreferredDeviceKey
    //指定如果是渲染则使用Metal：SCNPreferLowPowerDeviceKey
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
