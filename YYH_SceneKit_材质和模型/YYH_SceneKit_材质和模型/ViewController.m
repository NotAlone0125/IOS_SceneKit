//
//  ViewController.m
//  YYH_SceneKit_材质和模型
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
    
    SCNSphere * sphere=[SCNSphere sphereWithRadius:1];
    SCNNode * sphereNode=[SCNNode nodeWithGeometry:sphere];
    [scnView.scene.rootNode addChildNode:sphereNode];
    
#pragma mark +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//    /*
//     a.漫发射属性(diffuse) 我们有一长图片:
//     1.这个属性设置的几何体的基本的颜色,好比是你穿的衣服。
//     2.如果你不设置这个属性,它默认的contents内容是颜色white
//     其实它的过程像穿衣服一样
//     */
//    sphere.firstMaterial.diffuse.contents=@"earth-diffuse.jpg";
//    
//    
//    //影响环境光的相应属性(ambient)
//    sphere.firstMaterial.locksAmbientWithDiffuse=true;
//    sphere.firstMaterial.ambient.contents=[UIColor blueColor];
//    
//    
//    // 添加环境光
//    SCNNode *ambientlightNode = [SCNNode node];
//    ambientlightNode.light =[SCNLight light];
//    ambientlightNode.light.type = SCNLightTypeAmbient;
//    [scnView.scene.rootNode addChildNode:ambientlightNode];
//
//    
//    //添加一张高光图片
//    sphere.firstMaterial.specular.contents=@"earth-specular.jpg";
//    
//    
//    //映射因子
//    sphere.firstMaterial.reflective.contents=@"earth-reflective.jpg";
//    //映射因子没有上限值
//    sphere.firstMaterial.fresnelExponent=10;
    

#pragma mark +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //设置自身发光，不能照亮别的物体
//    SCNNode * spotLightNode=[SCNNode node];
//    spotLightNode.position=SCNVector3Make(0, 50, 0);
//    spotLightNode.rotation=SCNVector4Make(1, 0, 0, -M_PI/2.0);
//    spotLightNode.light=[SCNLight light];
//    spotLightNode.light.color=[UIColor blackColor];
//    spotLightNode.light.type=SCNLightTypeSpot;
//    [scnView.scene.rootNode addChildNode:spotLightNode];
//    
//    //添加一个自身发光的纹理图片
//    sphere.firstMaterial.emission.contents=@"earth-emissive.jpg";
//    
//    
//    //设置材质的透明度，也就是让这个几何物体的部分或者全部能变成透明的
//    sphere.firstMaterial.transparent.contents=@"cloudsTransparency";
//    sphere.firstMaterial.transparencyMode=SCNTransparencyModeRGBZero;
//    //设置透明比例，0为不透明，没有上限
//    sphere.firstMaterial.transparency=2;
//    
//    
//    SCNSphere * sphere1=[SCNSphere sphereWithRadius:1];
//    SCNNode * sphereNode1=[SCNNode nodeWithGeometry:sphere1];
//    sphereNode1.position=SCNVector3Make(0, 5, 0);
//    [scnView.scene.rootNode addChildNode:sphereNode1];
    
#pragma mark +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //设置一个颜色值和物体着色完成够的值相乘
    sphere.firstMaterial.diffuse.contents=@"earth-diffuse.jpg";
    //sphere.firstMaterial.emission.contents=@"earth-emissive.jpg";
    sphere.firstMaterial.multiply.contents=[UIColor greenColor];
    
    //设置自照明,如果selfIllumination属性不为nil, emission 属性则不起作用 , 把所用的光照全部去掉
    sphere.firstMaterial.selfIllumination.contents=[UIColor blueColor];
}




@end
