//
//  ViewController.m
//  YYH_SceneKit_SCNAction
//
//  Created by 杨昱航 on 2017/6/27.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
/*
 1.移动
 a.移动相对于当前位置
 + (SCNAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY z:(CGFloat)deltaZ duration:(NSTimeInterval)duration;
 + (SCNAction *)moveBy:(SCNVector3)delta duration:(NSTimeInterval)duration;
 
 b.移动到指定的位置
 + (SCNAction *)moveTo:(SCNVector3)location duration:(NSTimeInterval)duration;
 
 2旋转
 a.相对于当前位置旋转
 + (SCNAction *)rotateByX:(CGFloat)xAngle y:(CGFloat)yAngle z:(CGFloat)zAngle duration:(NSTimeInterval)duration;
 + (SCNAction *)rotateByAngle:(CGFloat)angle aroundAxis:(SCNVector3)axis duration:(NSTimeInterval)duration;
 
 b. 旋转到指定的位置
 + (SCNAction *)rotateToX:(CGFloat)xAngle y:(CGFloat)yAngle z:(CGFloat)zAngle duration:(NSTimeInterval)duration;
 + (SCNAction *)rotateToX:(CGFloat)xAngle y:(CGFloat)yAngle z:(CGFloat)zAngle duration:(NSTimeInterval)duration shortestUnitArc:(BOOL)shortestUnitArc;
 + (SCNAction *)rotateToAxisAngle:(SCNVector4)axisAngle duration:(NSTimeInterval)duration;
 
 3.缩放
 a.相对于当前的尺寸缩放
 + (SCNAction *)scaleBy:(CGFloat)scale duration:(NSTimeInterval)sec;
 
 b.缩放到指定的比例
 + (SCNAction *)scaleTo:(CGFloat)scale duration:(NSTimeInterval)sec;
 
 4.透明度
 a.透明度增加到1
 + (SCNAction *)fadeInWithDuration:(NSTimeInterval)sec;
 
 b.透明减小到0
 + (SCNAction *)fadeOutWithDuration:(NSTimeInterval)sec;
 
 c.透明度逐渐递增
 + (SCNAction *)fadeOpacityBy:(CGFloat)factor duration:(NSTimeInterval)sec;
 
 d.透明度逐渐递减
 + (SCNAction *)fadeOpacityTo:(CGFloat)opacity duration:(NSTimeInterval)sec;
 
 5.隐藏或不隐藏(让节点隐藏或者不隐藏)
 + (SCNAction *)hide NS_AVAILABLE(10_11, 9_0);
 + (SCNAction *)unhide NS_AVAILABLE(10_11, 9_0);
 
 6.等待
 a.等待指定时间
 + (SCNAction *)waitForDuration:(NSTimeInterval)sec;
 
 b.等待随机时间
 + (SCNAction *)waitForDuration:(NSTimeInterval)sec withRange:(NSTimeInterval)durationRange;
 
 7.从父节点移除子节点
 + (SCNAction *)removeFromParentNode;
 
 特殊函数介绍
 a.让行为相反
 - (SCNAction *)reversedAction;
 
 b.让行为永久执行
 + (SCNAction *)repeatActionForever:(SCNAction *)action;
 
 c.让行为执行N次
 + (SCNAction *)repeatAction:(SCNAction *)action count:(NSUInteger)count;
 
 d.把多个行为放在数组中一个一个执行
 + (SCNAction *)sequence:(NSArray<SCNAction *> *)actions;
 
 e.把多个行为进行捆绑 一次执行
 + (SCNAction *)group:(NSArray<SCNAction *> *)actions;
 
 f.执行代码块
 + (SCNAction *)runBlock:(void (^)(SCNNode *node))block;
 + (SCNAction *)runBlock:(void (^)(SCNNode *node))block queue:(dispatch_queue_t)queue;
 
 自定义动画介绍
 + (SCNAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(SCNNode *node, CGFloat elapsedTime))block;
 
 javaScript动画函数介绍
 a.创建一个行为执行一个javaScript程序 
 + (SCNAction *)javaScriptActionWithScript:(NSString *)script duration:(NSTimeInterval)seconds;
 
 在节点位置播放声音
 + (SCNAction *)playAudioSource:(SCNAudioSource *)source waitForCompletion:(BOOL)wait NS_AVAILABLE(10_11, 9_0);

 */
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SCNView *scnView = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView .backgroundColor = [UIColor blackColor];
    [self.view addSubview:scnView ];
    scnView.scene = [SCNScene scene];
    
    scnView.scene = [SCNScene scene];

    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode =[SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 50);
    [scnView.scene.rootNode addChildNode:cameraNode];

    SCNBox *box = [SCNBox boxWithWidth:10 height:10 length:10 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"fuImage.jpeg"];
    SCNNode *boxNode =[SCNNode node];
    boxNode.position = SCNVector3Make(0, 0, 0);
    boxNode.geometry = box;
    [scnView .scene.rootNode addChildNode:boxNode];

    
    //添加动画行为
    //创建动画行为
    SCNAction * rotation=[SCNAction rotateByAngle:10 aroundAxis:SCNVector3Make(0, 1, 1) duration:2];
    SCNAction *moveUp = [SCNAction moveTo:SCNVector3Make(0, 15, 0) duration:1];
    SCNAction *moveDown = [SCNAction moveTo:SCNVector3Make(0, -15, 0) duration:1];
    // 顺序执行的动画
    SCNAction *sequence = [SCNAction sequence:@[moveUp,moveDown]];
    // 组合动画的执行
    SCNAction *group = [SCNAction group:@[sequence ,rotation]];
    [boxNode runAction:[SCNAction repeatActionForever:group]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
