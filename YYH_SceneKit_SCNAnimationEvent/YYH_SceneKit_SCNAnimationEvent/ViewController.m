//
//  ViewController.m
//  YYH_SceneKit_SCNAnimationEvent
//
//  Created by 杨昱航 on 2017/7/4.
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
    
    
    SCNView * scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.scene = [SCNScene scene];
    scnView.allowsCameraControl=YES;
    [self.view addSubview:scnView];
    
    SCNCamera * camera = [SCNCamera camera];
    SCNNode * cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.camera.automaticallyAdjustsZRange=YES;
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    //添加环境光
    SCNNode * lightNode=[SCNNode node];
    lightNode.light=[SCNLight light];
    lightNode.light.type=SCNLightTypeAmbient;
    [scnView.scene.rootNode addChildNode:lightNode];
    
    //创建文字节点
    SCNText * text=[SCNText textWithString:@"SceneKit" extrusionDepth:1];
    text.font=[UIFont systemFontOfSize:1];
    SCNNode * textNode=[SCNNode nodeWithGeometry:text];
    textNode.position=SCNVector3Make(-2, -0.5, -2);
    [scnView.scene.rootNode addChildNode:textNode];
    
    /*
     初始化方法的参数解释
     1.time 这个参数你必须注意了,特别重要,它的取值范围[0-1] ,你可能要问为什么,这个时间参数是一个相对时间,不管你动画时间多长,这个动画时间需要传的参数,就只能是这个范围的值
     2.SCNAnimationEventBlock 回调事件的参数,你会发现没有说明,官方也没有具体给出说明,不过我们有调试工具,日志输出一下,就知道了,看文章的你幸运了我现在就告诉你参数是什么一下,第一个参数CAAnimation 类型,就是我们创建的动画,第二个参数any 当动画添加到节点上,那这个就是节点对象,第三个参数 动画是否回退执行
     
     重点内容来了,我们做一个颜色变化的事件,当动画开始执行是,我们的文字颜色为红色,动画指定一般颜色为紫色,动画执行完整时,颜色为绿色,我们重复这个行为
     */
    
    //创建三个事件
    SCNAnimationEvent * startEvent=[SCNAnimationEvent animationEventWithKeyTime:0 block:^(CAAnimation * _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
        SCNNode * node=(SCNNode *)animatedObject;
        node.geometry.firstMaterial.diffuse.contents=[UIColor redColor];
    }];
    SCNAnimationEvent * midEvent=[SCNAnimationEvent animationEventWithKeyTime:0.5 block:^(CAAnimation * _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
        SCNNode * node=(SCNNode *)animatedObject;
        node.geometry.firstMaterial.diffuse.contents=[UIColor purpleColor];
    }];
    SCNAnimationEvent * endEvent=[SCNAnimationEvent animationEventWithKeyTime:1 block:^(CAAnimation * _Nonnull animation, id  _Nonnull animatedObject, BOOL playingBackward) {
        SCNNode * node=(SCNNode *)animatedObject;
        node.geometry.firstMaterial.diffuse.contents=[UIColor grayColor];
    }];
    
    //创建一个动画将三个时间添加进去
    CABasicAnimation * basicAnimation=[CABasicAnimation animationWithKeyPath:@"position.z"];
    
    basicAnimation.duration=5;
    basicAnimation.fromValue=@0;
    basicAnimation.toValue=@-20;
    [basicAnimation setAdditive:YES];
    basicAnimation.autoreverses=TRUE;
    basicAnimation.animationEvents=@[startEvent,midEvent,endEvent];
    basicAnimation.repeatCount=INT64_MAX;
    [textNode addAnimation:basicAnimation forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
