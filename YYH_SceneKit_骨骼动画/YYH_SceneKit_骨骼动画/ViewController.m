//
//  ViewController.m
//  YYH_SceneKit_骨骼动画
//
//  Created by 杨昱航 on 2017/6/29.
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
    
    //SCNSkinner类
    /*
     SCNKinner 能干什么?
     提供一些方法可以将节点的骨骼动画进行分离,你可以使用这个对象管理从Scene文件导入的骨骼动画与节点和几何对象之间动态关系。这个类在平时开发过程中,不怎么用的,大家了解一下即可!
     怎么使用骨骼动画？
     1.一般情况下,游戏设计师使用3D 工具创建一个皮肤模型,包含了骨骼的动画,保存在一个场景文件中,你从场景文件中导入这个骨骼模型,然后让他们运动起来.
     2.另外你也可以直接从场景文件中导入动画对象直接操作骨头节点
     3.您还可以单独创建一个自定义的几何和骨架数据的皮肤模型
     */
    
    
    /*
     首先先介绍一个类(SCNSceneSource)
     
     主要用于管理场景文件的读取任务,也可以读取NSData对象哦!你懂了吧,如果这个模型,我们从网络传输的话,可能就需要使用这个类了。
     这个类暂时不详细讲解,后面我会补上,今天主要用到它的两几个方法。
     
     N0.1
     
     - (NSArray<NSString *> *)identifiersOfEntriesWithClass:(Class)entryClass;
     作用:获取场景中包含的某一类对象的标识(数组),可以获取的类型有 SCNMaterial, SCNScene, SCNGeometry, SCNNode, CAAnimation, SCNLight, SCNCamera, SCNSkinner, SCNMorpher, NSImage
     
     NO.2
     
     - (nullable id)entryWithIdentifier:(NSString *)uid withClass:(Class)entryClass;
     作用:根据对象的ID 和对象的类型，获取对象本身
     
     NO.3
     
     + (nullable instancetype)sceneSourceWithURL:(NSURL *)url options:(nullable NSDictionary<NSString *, id> *)options;
     作用:初始化方法
     
     NO.4
     
     - (nullable SCNScene *)sceneWithOptions:(nullable NSDictionary<NSString *, id> *)options error:(NSError **)error;
     */
    SCNView *scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.allowsCameraControl=YES;
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 5);
    [scnView.scene.rootNode addChildNode:cameraNode];

    
    //创建场景资源对象
    SCNSceneSource * sceneSource=[SCNSceneSource sceneSourceWithURL:[[NSBundle mainBundle] URLForResource:@"monster" withExtension:@"dae"] options:nil];
    scnView.scene = [sceneSource sceneWithOptions:nil error:nil];
    
    //获取场景中的某种对象的标识数组
    NSArray * animationIDs=[sceneSource identifiersOfEntriesWithClass:[CAAnimation class]];
    
    
    //把每个动画帧放到一个大数组中
    
    NSUInteger animationCount = [animationIDs count];
    NSLog(@"animationCount--%lu",(unsigned long)animationCount);//35
    
    NSMutableArray *longAnimations = [[NSMutableArray alloc] initWithCapacity:animationCount];
    CFTimeInterval maxDuration = 0;
    for (NSInteger index = 0; index < animationCount; index++) {
        CAAnimation *animation = [sceneSource entryWithIdentifier:animationIDs[index] withClass:[CAAnimation class]];
        if (animation) {
            maxDuration = MAX(maxDuration, animation.duration);
            NSLog(@"maxDuration--%f",maxDuration);
            [longAnimations addObject:animation];
        }
    }
    
    
    //创建一个动画组
    CAAnimationGroup *longAnimationsGroup = [[CAAnimationGroup alloc] init];
    longAnimationsGroup.animations = longAnimations;
    longAnimationsGroup.duration = maxDuration;
    
    
    //截取我们要的动画阶段比如(30~35秒)
    
    // 截取20秒之后的动画组
    CAAnimationGroup * idleAnimationGroup = [longAnimationsGroup copy];
    idleAnimationGroup.timeOffset = 30 ;
    // 创建一个重复执行这个动画的动画组
    CAAnimationGroup * lastAnimationGroup;
    lastAnimationGroup = [CAAnimationGroup animation];
    lastAnimationGroup.animations = @[idleAnimationGroup];
    lastAnimationGroup.duration = 35 -30;
    lastAnimationGroup.repeatCount = 10000;
    lastAnimationGroup.autoreverses = YES;
    
    //将动画组添加到模型节点
    SCNNode * cNode=[scnView.scene.rootNode childNodeWithName:@"Bip01_Neck" recursively:YES];
    [cNode addAnimation:lastAnimationGroup forKey:@"animation"];
    
    
    
    // 查看骨头
    SCNNode *skeletonNode = [scnView.scene.rootNode childNodeWithName:@"Bip01_Neck" recursively:YES];
    [self visualizeBones:true ofNode:skeletonNode inheritedScale:1];
    
}




- (void)visualizeBones:(BOOL)show ofNode:(SCNNode *)node inheritedScale:(CGFloat)scale
{
    // We propagate an inherited scale so that the boxes
    // representing the bones will be of the same size
    scale *= node.scale.x;
    
    if (show) {
        if (node.geometry == nil)
            node.geometry = [SCNBox boxWithWidth:6.0 / scale height:6.0 / scale length:6.0 / scale chamferRadius:0.5];
    }
    else {
        if ([node.geometry isKindOfClass:[SCNBox class]])
            node.geometry = nil;
    }
    
    for (SCNNode *child in node.childNodes)
        [self visualizeBones:show ofNode:child inheritedScale:scale];
}
























@end
