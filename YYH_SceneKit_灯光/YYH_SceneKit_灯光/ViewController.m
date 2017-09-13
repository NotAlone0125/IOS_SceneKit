//
//  ViewController.m
//  YYH_SceneKit_灯光
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
    
    //游戏视图
    SCNView * scnView=[[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:scnView];
    
    //场景
    scnView.allowsCameraControl=true;
    scnView.scene=[SCNScene scene];
    
    
    //节点
    SCNBox * box=[SCNBox boxWithWidth:0.5 height:0.5 length:0.5 chamferRadius:0];
    //box.firstMaterial.diffuse.contents=[UIColor yellowColor];
    SCNSphere * sphere=[SCNSphere sphereWithRadius:0.1];
    
    SCNNode * boxNode=[SCNNode node];
    boxNode.geometry=box;
    boxNode.position=SCNVector3Make(0, 0, -11);
    SCNNode * sphereNode=[SCNNode node];
    sphereNode.geometry=sphere;
    sphereNode.position=SCNVector3Make(0, 0, -10);
    
    [scnView.scene.rootNode addChildNode:boxNode];
    [scnView.scene.rootNode addChildNode:sphereNode];
    
    
    //给场景中添加环境光
//    SCNLight * light=[SCNLight light];
//    light.type=SCNLightTypeAmbient;
//    light.color=[UIColor yellowColor];
//    
//    SCNNode * lightNode=[SCNNode node];
//    lightNode.light=light;
//    [scnView.scene.rootNode addChildNode:lightNode];
//    //问题1：虽然光源为黄色，但是物体材质中没有黄色，所以不可能看到黄色。可以设置物体为黄色看看.
//    //问题2：系统为自动帮我们添加环境光，如果我们添加了，系统就不会添加，因此添不添加环境光看到的效果是相同的
    
    
    //给场景中添加点光源
//    SCNLight * light=[SCNLight light];
//    light.type=SCNLightTypeOmni;
//    light.color=[UIColor orangeColor];
//    
//    SCNNode * lightNode=[SCNNode node];
//    lightNode.light=light;
//    lightNode.position=SCNVector3Make(0, 100, 100);
//    //lightNode.position=SCNVector3Make(0, 100, 100);//换个位置看看
//    [scnView.scene.rootNode addChildNode:lightNode];
    
    
    //给场景中添加平行光源
//    SCNLight * light=[SCNLight light];
//    light.type=SCNLightTypeDirectional;
//    light.color=[UIColor greenColor];
//    
//    SCNNode * lightNode=[SCNNode node];
//    lightNode.light=light;
//    //lightNode.position=SCNVector3Make(0, 10, 100);
//    lightNode.position=SCNVector3Make(1000, 1000, 1000);//没有变化
//    //lightNode.rotation=SCNVector4Make(1, 0, 0, -M_PI/2.0);//这种光的默认照射方向是Z轴负方向，我们将其设置为Y轴负方向
//    [scnView.scene.rootNode addChildNode:lightNode];
    
    
    
    //给场景中添加聚焦光源
    SCNLight * light=[SCNLight light];
    light.type=SCNLightTypeSpot;
    light.color=[UIColor yellowColor];
    light.castsShadow=true;//捕捉阴影，只在点光源和平行光源起作用
    
    //改变一些属性
    light.zFar=10;//能照射的最远单位
    //因为物体存在漫反射，所有还能看到后面的正方体，要想看不见，添加下面一行代码
    light.spotOuterAngle=2;//设置光的发射角度
    
    SCNNode * lightNode=[SCNNode node];
    lightNode.light=light;
    lightNode.position=SCNVector3Make(0, 0, -9);
    [scnView.scene.rootNode addChildNode:lightNode];
    
    
    
    /*其他属性
     @property(nonatomic, copy, nullable) NSString *name;名称，用来索引
     
     @property(nonatomic, retain) id shadowColor;阴影的颜色，默认为50%的黑色
     
     @property(nonatomic) CGFloat shadowRadius;阴影的采样角度，默认为3
     
     @property(nonatomic) CGSize shadowMapSize API_AVAILABLE(macosx(10.10));阴影贴图的大小，贴图越大，阴影越精确，但计算越慢，默认为{0，0}
     
     @property(nonatomic) NSUInteger shadowSampleCount API_AVAILABLE(macosx(10.10));设置每一帧计算阴影贴图的次数，默认为一次
     
     @property(nonatomic) SCNShadowMode shadowMode API_AVAILABLE(macosx(10.10));设置阴影模式（默认），SCNShadowModeForward   = 0,通过Alpha值的变化决定阴影
              SCNShadowModeDeferred  = 1,根据最后的颜色决定，一般不使用，除非多个光源同时作用
              SCNShadowModeModulated = 2,光没有作用，一般用于图案作为阴影的情况下，比如镜像渐变图像（黑白）
     
     @property(nonatomic) CGFloat shadowBias API_AVAILABLE(macosx(10.10));阴影的深度偏移量
     
     @property(nonatomic) CGFloat orthographicScale API_AVAILABLE(macosx(10.10));平行方向放阴影比例值调节
     
     @property(nonatomic) CGFloat zNear API_AVAILABLE(macosx(10.10));
     @property(nonatomic) CGFloat zFar API_AVAILABLE(macosx(10.10));光作用的范围
     
     @property(nonatomic) CGFloat attenuationStartDistance API_AVAILABLE(macosx(10.10));
     @property(nonatomic) CGFloat attenuationEndDistance API_AVAILABLE(macosx(10.10));
     @property(nonatomic) CGFloat attenuationFalloffExponent API_AVAILABLE(macosx(10.10));光衰减的开始距离和结束距离（Omni or Spot light）
     
     @property(nonatomic) CGFloat spotInnerAngle  API_AVAILABLE(macosx(10.10));
     @property(nonatomic) CGFloat spotOuterAngle  API_AVAILABLE(macosx(10.10));聚焦光的发射点的方向和光纤强度最弱的时候的夹角
     
     @property(nonatomic, readonly, nullable) SCNMaterialProperty *gobo API_AVAILABLE(macosx(10.9));用于碰撞检测
     
     @property(nonatomic) NSUInteger categoryBitMask API_AVAILABLE(macosx(10.10));点光源材质属性（只支持spot类型）
    */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
