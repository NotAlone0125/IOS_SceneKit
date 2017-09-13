//
//  ViewController.m
//  YYH_SceneKit01_介绍
//
//  Created by 杨昱航 on 2017/6/26.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupScnview];
}

//创建游戏专用场景
-(void)setupScnview
{
    //创建游戏专用视图
    SCNView * scnView=[[SCNView alloc]initWithFrame:self.view.bounds];
    //创建一个场景，系统默认是没有的
    scnView.scene=[SCNScene scene];
    //先设置一个颜色看看游戏殷勤有没有加载
    scnView.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:scnView];
    
    
    
    //创建一个文字节点
    SCNNode * textNode=[SCNNode node];
    SCNText * text=[SCNText textWithString:@"Scene Kit" extrusionDepth:0.5];
    textNode.geometry=text;
    //把这个文字节点添加到游戏场景的根节点上
    [scnView.scene.rootNode addChildNode:textNode];
    
    //允许用户操作相机，后面解释
    scnView.allowsCameraControl=true;
    
    
    /*
     概念
     SCNView：SCNView主要作用是显示SceneKit的3D内容，在ios系统上是UIView的子类，由于这个原因他可以添加到我们的视图中去，如果我们做一个应用想要加点3D元素，SceneKit绝对是首选。
     SCNScene：SCNScene为游戏中的场景，简单的说，就是放的游戏元素（地图，灯光，任务的游戏元素）的地方。
     SCNNode：SCNNode被称为节点，一个大型的游戏场景结构就是由无数个小的节点组成，它有自己的位置和自身坐标系统，我们可以把集合模型、灯光、摄像机的游戏中的真实元素，吸附到SCNNode节点上。
     SCNCamera：SCNCamera被称为照相机或者摄像机，游戏就相当于一个生活中的环境，我们可以通过照相机捕捉到你想要观察的画面。
     SCNLight：灯光，没有光线的话，我们是无法看到物体的，在游戏中也是一样，我们给游戏中添加不同的灯光，来模拟逼真的环境。
     SCNAudioSource：主要负责给游戏添加声音。
     SCNAction：主要负责改变节点的属性，比如我们要让一个地球围绕太阳旋转，一个气球从一个地方移动到另一个地方。
     SCNTransation：主要负责提交改变节点属性的事件。
     SCNGeometry：呈现三维模型的类，我们的模型长什么样子，都由该类决定。
     SCNMaterial：定义模型的外观。
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
