//
//  ViewController.m
//  YYH_SceneKit_游戏场景的切换
//
//  Created by 杨昱航 on 2017/7/3.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
#import <SpriteKit/SpriteKit.h>
/*
 场景切换,你应该想到的更换Scene,最简单的方式就是下面这种写法
 
 self.scnView.scene = scene;
 运行一下结果,和我们的预期一模一样。你学会了吧,很简单吧！不过就是有点挫而已,那我们怎么让它变的不这么low,就是给它添加过渡动画,目标明确那就去找方法。SCNScene 是SCNView的属性,那就去它里面找方法
 
 - (void)presentScene:(SCNScene *)scene withTransition:(SKTransition *)transition incomingPointOfView:(nullable SCNNode *)pointOfView completionHandler:(nullable void (^)())completionHandler NS_AVAILABLE(10_11, 9_0);
 参数说明:
 
 scene 你要切换到的场景
 transition 过渡动画类型
 pointOfView 切换到的场景中的照相机节点
 completionHandle 完成后的block块
 有一个参数我要说一下,transition 过渡动画类型 你会发现他是SKTransition 这个是什么类型呢? 悄悄的告诉你,苹果还有一个2D 游戏框架(SpriteKit) 这个类就是它里面的,简书上有人在写SpriteKit框架的教程,有兴趣的可以去搜。
 */
@interface ViewController ()
@property(nonatomic,strong)SCNView *scnView;
@property(strong,nonatomic)SCNNode *floorNode;
@property(strong,nonatomic)SCNScene *lastScene;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    self.scnView.backgroundColor = [UIColor blackColor];
    self.scnView.scene = [SCNScene scene];
    [self.view addSubview:self.scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 5);
    [self.scnView.scene.rootNode addChildNode:cameraNode];
    
    SCNNode *floorNode = [SCNNode node];
    self.floorNode = floorNode;
    floorNode.geometry = [SCNFloor floor];
    floorNode.geometry.firstMaterial.diffuse.contents = @"floor.jpg";
    floorNode.physicsBody = [SCNPhysicsBody staticBody];
    [self.scnView.scene.rootNode addChildNode:floorNode];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentScene1)];
    [self.scnView addGestureRecognizer:tap];
}


- (void)presentScene1{
    
    // 创建目标转换场景
    SCNScene *scene = [SCNScene scene];
    [scene.rootNode addChildNode:[[SCNScene sceneNamed:@"palm_tree.dae"].rootNode childNodeWithName:@"PalmTree" recursively:true]];
    // 添加一个照相机
    SCNNode *cameraNode1 = [SCNNode node];
    cameraNode1.camera = [SCNCamera camera];
    cameraNode1.position = SCNVector3Make(0, -100, -1000);
    cameraNode1.rotation = SCNVector4Make(1, 0, 0, M_PI);
    cameraNode1.camera.automaticallyAdjustsZRange = true;
    [scene.rootNode addChildNode:cameraNode1];
    
    // 引用上一个场景
    self.lastScene = self.scnView.scene;
    
    // 创建转换场景
    SKTransition *transition = [SKTransition doorwayWithDuration:1];
    [self.scnView presentScene:scene withTransition: transition incomingPointOfView:cameraNode1 completionHandler:^{
        
    }];
}


@end
