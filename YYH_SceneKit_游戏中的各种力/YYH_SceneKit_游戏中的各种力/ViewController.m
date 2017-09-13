//
//  ViewController.m
//  YYH_SceneKit_游戏中的各种力
//
//  Created by 杨昱航 on 2017/6/30.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

/*
 认识一个类(SCNPhysicsField)
 
 提示:这个类几乎包含了物理世界存在的各种力,我们要掌握它的属性的含义
 
 控制力的强度(默认为1.0):@property(nonatomic)  CGFloat  strength;
 
 决定力的衰减指数(默认为0),如果值不为0，力的计算公式是  (1  /  distance  ^  falloffExponent):@property(nonatomic)  CGFloat  falloffExponent;
 
 设置距离力中心点的最小不衰减距离,在这个范围内力不衰减(默认值为1e-6):@property(nonatomic)  CGFloat  minimumDistance;
 
 设置力的激活状态(默认为YES):@property(nonatomic,  getter=isActive)  BOOL  active;
 
 阻止任何在它作用范围内的力(默认为NO):@property(nonatomic,  getter=isExclusive)  BOOL  exclusive;
 
 决定力作用的范围:@property(nonatomic)  SCNVector3  halfExtent;
 
 决定作用的范围是个四方体还是一个球体(默认NO):@property(nonatomic)  BOOL  usesEllipsoidalExtent;
 
 决定力作用的范围是在指定的范围内，还是范围外:@property(nonatomic)  SCNPhysicsFieldScope  scope;
 
 力的中心到影响范围的偏移:@property(nonatomic)  SCNVector3  offset;
 
 力的方向(默认为(0,-1,0)),注意它只对线性力有影响，比如重力:@property(nonatomic)  SCNVector3  direction;
 
 决定哪些节点可以被影响(高级用法,暂时不讲,当学习了碰撞检测之后,在悄悄告诉你):@property(nonatomic)  NSUInteger  categoryBitMask  NS_AVAILABLE(10_10,  8_0);
 */

@interface ViewController ()
{
    SCNNode *floorNode;
}
@property(nonatomic,strong)SCNView * scnView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建游戏视图和游戏场景
    self.scnView = [[SCNView alloc]initWithFrame:self.view.bounds];
    self.scnView.backgroundColor = [UIColor blackColor];
    self.scnView.scene = [SCNScene scene];
    [self.view addSubview:self.scnView];
    self.scnView.allowsCameraControl = true;
    
    // 创建照相机
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0, 30, 30);
    cameraNode.rotation = SCNVector4Make(1, 0, 0, -M_PI/4);
    cameraNode.camera.automaticallyAdjustsZRange = true;
    [self.scnView.scene.rootNode addChildNode:cameraNode];
    
    // 创建一个地板
    floorNode = [SCNNode node];
    floorNode.geometry = [SCNFloor floor];
    floorNode.geometry.firstMaterial.diffuse.contents = @"floor.jpg";
    floorNode.physicsBody = [SCNPhysicsBody staticBody];
    [self.scnView.scene.rootNode addChildNode:floorNode];

    
    
#pragma mark +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    //[self dray];
    
    //[self vortex];
    
    //[self radialGravity];
    
    //[self addLineGravity];
    
    //[self addNoiseField];
    
    //[self addTurbulenceField];
    
    //[self addSpringFiled];
    
    //[self addElectricField];
    
    //[self addmagneticField];
    
    //结合粒子系统实现一个效果
    [self customScene];
}

//拖拽力
-(void)dray{
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = [SCNBox boxWithWidth:4 height:4 length:4 chamferRadius:0];
    boxNode.geometry.firstMaterial.diffuse.contents = [UIColor redColor];
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    [self.scnView.scene.rootNode addChildNode:boxNode];

    
    //添加一个30的拖拽力
    SCNNode * drayFieldNode=[SCNNode node];
    drayFieldNode.physicsField=[SCNPhysicsField dragField];
    drayFieldNode.physicsField.strength=30;
    drayFieldNode.physicsField.direction=SCNVector3Make(0, -1, 0);//拖拽力没有方向，只有大小,主要是阻碍物体的运动,如果真要说方向朝向哪里，就是和物体运动方向相反,如果物体没有速度,拖拽力不会对物体产生影响
    [boxNode addChildNode:drayFieldNode];
}

//围绕轴旋转的力
-(void)vortex{
    
    int count = 60;
    while (count) {
        SCNNode *ballNode = [SCNNode node];
        ballNode.geometry = [SCNSphere sphereWithRadius:1];
        ballNode.geometry.firstMaterial.diffuse.contents = @"ball";
        ballNode.physicsBody = [SCNPhysicsBody dynamicBody];
        ballNode.position = SCNVector3Make(0, arc4random_uniform(2), arc4random_uniform(2)-1);
        [self.scnView.scene.rootNode addChildNode:ballNode];
        count--;
    }
    
    SCNNode * vortextFieldNode=[SCNNode node];
    vortextFieldNode.physicsField=[SCNPhysicsField vortexField];
    vortextFieldNode.physicsField.strength=1;
    vortextFieldNode.physicsField.direction=SCNVector3Make(0, -1, 0);//改为(-1, 0, 0)试试，旋转力类似右手螺旋定则,设置的轴线方向为大拇指的指向的方向,手指环绕的方向才是力的方向。
    [self.scnView.scene.rootNode addChildNode:vortextFieldNode];
}
//创建朝向一个点的力
-(void)radialGravity{
    int count = 20;
    while (count) {
        SCNNode *ballNode = [SCNNode node];
        ballNode.geometry = [SCNSphere sphereWithRadius:1];
        ballNode.geometry.firstMaterial.diffuse.contents = @"ball";
        ballNode.physicsBody = [SCNPhysicsBody dynamicBody];
        ballNode.position = SCNVector3Make(arc4random_uniform(2), 0, 0);
        [self.scnView.scene.rootNode addChildNode:ballNode];
        count--;
    }
    
    SCNNode * radialGravityNode=[SCNNode node];
    radialGravityNode.physicsField=[SCNPhysicsField radialGravityField];
    radialGravityNode.physicsField.strength=1000;
    radialGravityNode.physicsField.direction=SCNVector3Make(0, 0, 0);
    [self.scnView.scene.rootNode addChildNode:radialGravityNode];
    //可以设置位置,力朝向设置的位置。如果设置负值,力是朝向外边的。
    
}
//线性力
-(void)addLineGravity
{
    int count = 10;
    while (count) {
        SCNNode *ballNode = [SCNNode node];
        ballNode.geometry = [SCNSphere sphereWithRadius:1];
        ballNode.geometry.firstMaterial.diffuse.contents = @"ball";
        ballNode.physicsBody = [SCNPhysicsBody dynamicBody];
        ballNode.position = SCNVector3Make(arc4random_uniform(2), 0, 0);
        [self.scnView.scene.rootNode addChildNode:ballNode];
        count--;
    }
    
    SCNNode * lineGravityNode = [SCNNode node];
    lineGravityNode.physicsField = [SCNPhysicsField linearGravityField];
    lineGravityNode.physicsField.strength = 100;
    lineGravityNode.physicsField.direction = SCNVector3Make(0, 0, -1);
    [self.scnView.scene.rootNode addChildNode:lineGravityNode];
}


//创建随机的力
//smoothness 噪点的平滑性 animationSpeed运动的速度
-(void)addNoiseField{
    int count = 10;
    while (count) {
        SCNNode *ballNode = [SCNNode node];
        ballNode.geometry = [SCNSphere sphereWithRadius:1];
        ballNode.geometry.firstMaterial.diffuse.contents = @"ball";
        ballNode.physicsBody = [SCNPhysicsBody dynamicBody];
        ballNode.position = SCNVector3Make(arc4random_uniform(2), 0, 0);
        [self.scnView.scene.rootNode addChildNode:ballNode];
        count--;
    }
    
    SCNNode * noiseFieldNode = [SCNNode node];
    noiseFieldNode.physicsField = [SCNPhysicsField noiseFieldWithSmoothness:0 animationSpeed:1];
    noiseFieldNode.physicsField.strength = 500;
    [self.scnView.scene.rootNode addChildNode:noiseFieldNode];
    //你知道用在什么地方吗?比如你想营造下雪的效果 或者 萤火虫效果，可以使用这个力
}
//一种和速度成正比的随机力
-(void)addTurbulenceField
{
    int count = 10;
    while (count) {
        SCNNode *ballNode = [SCNNode node];
        ballNode.geometry = [SCNSphere sphereWithRadius:1];
        ballNode.geometry.firstMaterial.diffuse.contents = @"ball";
        ballNode.physicsBody = [SCNPhysicsBody dynamicBody];
        ballNode.position = SCNVector3Make(arc4random_uniform(2), 0, 0);
        [self.scnView.scene.rootNode addChildNode:ballNode];
        count--;
    }
    
    SCNNode * addTurbulenceField=[SCNNode node];
    addTurbulenceField.physicsField=[SCNPhysicsField turbulenceFieldWithSmoothness:0 animationSpeed:1];
    addTurbulenceField.physicsField.strength=50;
    [self.scnView.scene.rootNode addChildNode:addTurbulenceField];
}

//弹性力(胡克定律)
-(void)addSpringFiled{
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = [SCNBox boxWithWidth:4 height:4 length:4 chamferRadius:0];
    boxNode.geometry.firstMaterial.diffuse.contents = [UIColor redColor];
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    [self.scnView.scene.rootNode addChildNode:boxNode];
    
    SCNNode * springNode=[SCNNode node];
    springNode.physicsField=[SCNPhysicsField springField];
    springNode.physicsField.strength=5;
    springNode.position=SCNVector3Make(0, 30, 0);
    [self.scnView.scene.rootNode addChildNode:springNode];
    //创建这个力,需要设置力的位置和力的大小
}

//电场
-(void)addElectricField
{
    //创建带电荷的节点对象
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = [SCNBox boxWithWidth:4 height:4 length:4 chamferRadius:0];
    boxNode.geometry.firstMaterial.diffuse.contents = [UIColor redColor];
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    boxNode.position = SCNVector3Make(0, 30, 0);
    boxNode.physicsBody.velocity = SCNVector3Make(0, 0, 0);
    [self.scnView.scene.rootNode addChildNode:boxNode];
    boxNode.physicsBody.charge = -10;//创建电荷正负和大小
    
    SCNNode * electricFieldNode=[SCNNode node];
    electricFieldNode.physicsField=[SCNPhysicsField electricField];
    electricFieldNode.physicsField.strength=5;
    [self.scnView.scene.rootNode addChildNode:electricFieldNode];
    //电场默认的属相是正的
}

//创建磁场
-(void)addmagneticField
{
    //创建带电荷的节点对象
    SCNNode *boxNode = [SCNNode node];
    boxNode.geometry = [SCNBox boxWithWidth:4 height:4 length:4 chamferRadius:0];
    boxNode.geometry.firstMaterial.diffuse.contents = [UIColor redColor];
    boxNode.physicsBody = [SCNPhysicsBody dynamicBody];
    //boxNode.position = SCNVector3Make(0, 0, 0);
    //boxNode.physicsBody.velocity = SCNVector3Make(0, 0, 0);
    [self.scnView.scene.rootNode addChildNode:boxNode];
    boxNode.physicsBody.charge = -10;//创建电荷正负和大小
    
    SCNNode * magneticFieldNode=[SCNNode node];
    magneticFieldNode.physicsField=[SCNPhysicsField magneticField];
    magneticFieldNode.physicsField.strength=15;
    [self.scnView.scene.rootNode addChildNode:magneticFieldNode];
    //吸引或者排斥物体,取决于电荷的大小,正负,速度,距离等因素
}

//自定义力，之后再讲

//结合粒子系统实现一个效果
-(void)customScene
{
    SCNTube * tube=[SCNTube tubeWithInnerRadius:1 outerRadius:1.2 height:4];
    tube.firstMaterial.diffuse.contents=[UIImage imageNamed:@"ball"];
    SCNNode * tubeNode=[SCNNode nodeWithGeometry:tube];
    tubeNode.position=SCNVector3Make(-5, 2, 0);
    tubeNode.physicsBody=[SCNPhysicsBody kinematicBody];
    [self.scnView.scene.rootNode addChildNode:tubeNode];
    
    
    SCNParticleSystem * fire=[SCNParticleSystem particleSystemNamed:@"fire.scnp" inDirectory:nil];
    //设置和粒子产生碰撞的节点
    fire.colliderNodes=@[tubeNode,floorNode];
    fire.affectedByPhysicsFields=YES;//让粒子可以受力的影响
    
    //设置粒子的电荷
    fire.particleCharge=10;
    
    SCNNode * fireNode=[SCNNode node];
    fireNode.position=SCNVector3Make(0, 0, 0);
    [fireNode addParticleSystem:fire];
    fireNode.physicsBody=[SCNPhysicsBody dynamicBody];
    [tubeNode addChildNode:fireNode];
    
 
    
    //在创建一个圆筒，并给其添加一个电场
    SCNNode * tudeNode2=[SCNNode nodeWithGeometry:[SCNTube tubeWithInnerRadius:4.5 outerRadius:5 height:2]];
    tudeNode2.position=SCNVector3Make(6, 1, 0);
    tudeNode2.geometry.firstMaterial.diffuse.contents=[UIImage imageNamed:@"ball"];
    [self.scnView.scene.rootNode addChildNode:tudeNode2];
    
    SCNNode * electricFieldNode=[SCNNode node];
    electricFieldNode.physicsField=[SCNPhysicsField electricField];
    electricFieldNode.physicsField.strength=-10;
    [tudeNode2 addChildNode:electricFieldNode];
    
    
}




@end
