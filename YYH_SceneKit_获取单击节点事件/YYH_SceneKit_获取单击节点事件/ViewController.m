//
//  ViewController.m
//  YYH_SceneKit_获取单击节点事件
//
//  Created by 杨昱航 on 2017/7/4.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>
@interface ViewController ()
{
    SCNView *scnView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    scnView  = [[SCNView alloc]initWithFrame:self.view.bounds];
    scnView.backgroundColor = [UIColor blackColor];
    scnView.scene = [SCNScene scene];
    scnView.allowsCameraControl=YES;
    [self.view addSubview:scnView];
    
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.camera.automaticallyAdjustsZRange=YES;
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    //[scnView hitTest:<#(CGPoint)#> options:<#(nullable NSDictionary<SCNHitTestOption,id> *)#>]
    
    //添加一个手势
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taphandle:)];
    [scnView addGestureRecognizer:tap];
}

-(void)taphandle:(UITapGestureRecognizer *)gesture
{
    
    NSArray * results=[scnView hitTest:[gesture locationOfTouch:0 inView:scnView] options:nil];
    SCNHitTestResult * firstResult=[results firstObject];
    NSLog(@"%@",firstResult.node);
    
    /*
     /// 击中的节点
     open var node: SCNNode { get }
     
     /// 击中的几何体索引
     open var geometryIndex: Int { get }
     
     /// 击中的面的索引
     open var faceIndex: Int { get }
     
     /// 击中的本地坐标系统
     open var localCoordinates: SCNVector3 { get }
     
     
     /// 击中的世界坐标系统
     open var worldCoordinates: SCNVector3 { get }
     
     
     /// 击中节点的本地法线坐标
     open var localNormal: SCNVector3 { get }
     
     
     /// 击中的世界坐标系统的法线坐标
     open var worldNormal: SCNVector3 { get }
     
     
      World transform of the node intersected.
    //open var modelTransform: SCNMatrix4 { get }
    
    
    The bone node hit. Only available if the node hit has a SCNSkinner attached.
    //@available(iOS 10.0, *)
    //open var boneNode: SCNNode { get }
    
    
    
     @method textureCoordinatesWithMappingChannel:
     @abstract Returns the texture coordinates at the point of intersection, for a given mapping channel.
     @param channel The texture coordinates source index of the geometry to use. The channel must exists on the geometry otherwise {0,0} will be returned.
     open func textureCoordinates(withMappingChannel channel: Int) -> CGPoint
    */

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
