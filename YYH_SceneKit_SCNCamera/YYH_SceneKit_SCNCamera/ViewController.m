//
//  ViewController.m
//  YYH_SceneKit_SCNCamera
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
    SCNView * scnView=[[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:scnView];
    scnView.allowsCameraControl=true;
    
    //场景
    scnView.scene=[SCNScene scene];

    //添加照相机
    SCNCamera * camera=[SCNCamera camera];
    SCNNode * cameraNode=[SCNNode node];
    cameraNode.camera=camera;
    cameraNode.position=SCNVector3Make(0, 0, 50);
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    //添加两个正方体
    SCNBox * box1=[SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box1.firstMaterial.diffuse.contents=[UIImage imageNamed:@"chiImage.jpeg"];
    SCNNode * box1Node=[SCNNode node];
    box1Node.geometry=box1;
    [scnView.scene.rootNode addChildNode:box1Node];
    
    SCNBox * box2=[SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box2.firstMaterial.diffuse.contents=[UIImage imageNamed:@"fuImage.jpeg"];
    SCNNode * box2Node=[SCNNode node];
    box2Node.position=SCNVector3Make(0, 10, -20);
    box2Node.geometry=box2;
    [scnView.scene.rootNode addChildNode:box2Node];
    
    
    //属性的效果之间可能会相互覆盖，建议单一设置一个属性，以查看效果
    //调节X轴和Y轴视角(默认都为60度)
//    camera.xFov=20;
//    camera.yFov=20;
    
    //设置焦距（默认为10）
//    camera.focalDistance=45;
//    //camera.focalBlurRadius=1;//默认为0，模糊物体模糊度
    
    //设置相机的最远能照到的物体（默认为100）
    //camera.zFar=60;
    
    //设置正投影（正投影就是说物体在远离或者靠近照相机时，大小保持不变）
    camera.usesOrthographicProjection=true;
    //设置正投影的比例（默认为1，比例越大，显示的图像越小，可以理解为scale=屏幕大小：图片大小）
    camera.orthographicScale=100;
    
    
    /*
     其他属性:
     @property(nonatomic, copy, nullable) NSString *name;名称
     @property(nonatomic) double zNear;设置相机的最近能照到的物体（默认为1）
     @property(nonatomic) BOOL automaticallyAdjustsZRange API_AVAILABLE(macosx(10.9));让相机自动调节最近和最远距离（默认关闭，开启后，没有最近和最远的限制）
     @property(nonatomic) CGFloat aperture API_AVAILABLE(macosx(10.9));决定进入焦点和离开焦点的过渡速度
     @property(nonatomic) NSUInteger categoryBitMask API_AVAILABLE(macosx(10.10));用于检测节点碰撞使用
     */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
