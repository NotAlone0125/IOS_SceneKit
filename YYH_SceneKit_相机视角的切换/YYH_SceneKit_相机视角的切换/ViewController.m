//
//  ViewController.m
//  YYH_SceneKit_相机视角的切换
//
//  Created by 杨昱航 on 2017/6/30.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
@interface ViewController ()
{
    SCNView *scnView;
    SCNNode * thirdViewCamera;
    SCNNode * firstViewCamera;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    

    scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.scene = [SCNScene scene];
    [self.view addSubview:scnView];

    
    //创建太阳系(也很简单)
    
    SCNNode *sunNode = [SCNNode node];
    sunNode.geometry = [SCNSphere sphereWithRadius:3];
    sunNode.geometry.firstMaterial.diffuse.contents = @"sun.jpg";
    [scnView.scene.rootNode addChildNode:sunNode];
    
    //创建地月系(有点复杂哦)
    // 1.我们需要先创建一个地月系节点.并且设置它为太阳系的子节点
    SCNNode *earthMoonNode = [SCNNode node];
    earthMoonNode.position = SCNVector3Make(10, 0, 0);
    [sunNode addChildNode:earthMoonNode];
    
    //2.创建一个地球节点,添加到地月系节点上去
    SCNNode *earthNode = [SCNNode node];
    earthNode.geometry = [SCNSphere sphereWithRadius:1];
    earthNode.geometry.firstMaterial.diffuse.contents = @"earth.jpg";
    earthNode.position = SCNVector3Make(0, 0, 0);
    [earthMoonNode  addChildNode:earthNode];
    
    // 3.创建一个月球系，让它添加到地球节点上去
    SCNNode *moonNode = [SCNNode node];
    moonNode.geometry = [SCNSphere sphereWithRadius:0.5];
    moonNode.geometry.firstMaterial.diffuse.contents = @"moon.jpg";
    moonNode.position = SCNVector3Make(2, 0, 0);
    [earthNode addChildNode:moonNode];
    
    
    //运动
    //1.太阳绕着Y轴自传
    SCNAction *sunRotate = [SCNAction repeatActionForever:[SCNAction rotateByAngle:0.1 aroundAxis:SCNVector3Make(0, 1, 0) duration:0.3]];
    [sunNode runAction:sunRotate];
    
    // 2.地球绕着Y轴自传
    SCNAction *rotation =[SCNAction repeatActionForever:[SCNAction rotateByAngle:0.1 aroundAxis:SCNVector3Make(0, 1, 0) duration:0.05]];
    [earthNode runAction:rotation];
    
    
    
    //创建两个视角
    // 1.我们创建一个场景范围内的第三视角
    thirdViewCamera = [SCNNode node];
    thirdViewCamera.camera = [SCNCamera camera];
    thirdViewCamera.camera.automaticallyAdjustsZRange = true;
    thirdViewCamera.position = SCNVector3Make(0, 0, 30);
    [scnView.scene.rootNode addChildNode:thirdViewCamera];
    
    // 2.我们创建一个地月系的第一视角
    firstViewCamera = [SCNNode node];
    firstViewCamera.camera =[SCNCamera camera];
    firstViewCamera.position = SCNVector3Make(0, 0, 10);
    [earthMoonNode addChildNode:firstViewCamera];
    
    NSArray * array=@[@"进入太阳系",@"进入地月系",@"离开太阳系"];
    for (int i=0; i<3; i++)
    {
        UIButton * button=[UIButton buttonWithType:UIButtonTypeSystem];
        button.frame=CGRectMake(10, 10+40*i, 80, 30);
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.tag=i;
        [button addTarget:self action:@selector(changeCarmera:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
}

-(void)changeCarmera:(UIButton *)button
{
    switch (button.tag) {
        case 0://进入太阳系
        {
            scnView.pointOfView = thirdViewCamera;
            SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 0, 30) duration:1];
            [thirdViewCamera runAction:move];
        }
            break;
        case 1:// 进入地月系
        {
            scnView.pointOfView = firstViewCamera;
        }
            break;
        case 2://离开太阳系
        {
            SCNAction *move = [SCNAction moveTo:SCNVector3Make(0, 0, 400) duration:1];
            [thirdViewCamera runAction:move];
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
