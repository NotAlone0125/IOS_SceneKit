//
//  ViewController.m
//  YYH_SceneKit_滤镜效果
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
    
    SCNView * scnView=[[SCNView alloc]initWithFrame:self.view.bounds options:@{SCNViewOptionPreferredRenderingAPI:@"true"}];
    scnView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:scnView];

    SCNScene * scene=[SCNScene scene];
    scnView.scene=scene;
    
    SCNNode * cameraNode=[SCNNode node];
    cameraNode.camera=[SCNCamera camera];
    [scnView.scene.rootNode addChildNode:cameraNode];
    
    SCNBox * box=[SCNBox boxWithWidth:1 height:1 length:1 chamferRadius:0];
    box.firstMaterial.diffuse.contents=@"1.png";
    SCNNode * boxNode=[SCNNode nodeWithGeometry:box];
    boxNode.position=SCNVector3Make(0, 0, -2);
    [scnView.scene.rootNode addChildNode:boxNode];
    
    
    //简单的滤镜效果
    //1.
    CIFilter * filter1=[CIFilter filterWithName:@"CIEdgeWork"];
    boxNode.filters=@[filter1];
    
    //2.
    CIFilter * filter2=[CIFilter filterWithName:@"CIGaussianBlur"];
    [filter2 setDefaults];
    [filter2 setValue:@10 forKey:kCIInputRadiusKey];
    boxNode.filters=@[filter2];
    
    //3.
    CIFilter * filter3=[CIFilter filterWithName:@"CISepiaTone"];
    [filter3 setDefaults];
    [filter3 setValue:@0.8 forKey:kCIInputIntensityKey];
    boxNode.filters=@[filter3];
    
    //4.
    CIFilter * filter4=[CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputIntensityKey,@5,nil];
    boxNode.filters=@[filter4];
    
    //5.
    CIFilter * filter5=[CIFilter filterWithName:@"CIPixellate" keysAndValues:kCIInputScaleKey,@10.0,nil];
    boxNode.filters=@[filter5];
    
    //6.
    CIFilter * filter6=[CIFilter filterWithName:@"CIPhotoEffectProcess"];
    boxNode.filters=@[filter6];
    
    
    //组合使用
    boxNode.filters=@[filter5,filter6];
    
    
    /*
     系统框架提供了很多滤镜效果,上面只是冰山一角,应该都满足大多数的滤镜效果,如果你真的需要自定义滤镜效果,那你可以使用 CIKernel,CISampler, CIFilterShape 他们 或者GLSL 进行自定义滤镜设计
     
     参考
     
     CIAdditionCompositing     //影像合成
     CIAffineTransform           //仿射变换
     CICheckerboardGenerator       //棋盘发生器
     CIColorBlendMode              //CIColor混合模式
     CIColorBurnBlendMode          //CIColor燃烧混合模式
     CIColorControls
     CIColorCube                   //立方体
     CIColorDodgeBlendMode         //CIColor避免混合模式
     CIColorInvert                 //CIColor反相
     CIColorMatrix                 //CIColor矩阵
     CIColorMonochrome             //黑白照
     CIConstantColorGenerator      //恒定颜色发生器
     CICrop                        //裁剪
     CIDarkenBlendMode             //亮度混合模式
     CIDifferenceBlendMode         //差分混合模式
     CIExclusionBlendMode          //互斥混合模式
     CIExposureAdjust              //曝光调节
     CIFalseColor                  //伪造颜色
     CIGammaAdjust                 //灰度系数调节
     CIGaussianGradient            //高斯梯度
     CIHardLightBlendMode          //强光混合模式
     CIHighlightShadowAdjust       //高亮阴影调节
     CIHueAdjust                   //饱和度调节
     CIHueBlendMode                //饱和度混合模式
     CILightenBlendMode
     CILinearGradient              //线性梯度
     CILuminosityBlendMode         //亮度混合模式
     CIMaximumCompositing          //最大合成
     CIMinimumCompositing          //最小合成
     CIMultiplyBlendMode           //多层混合模式
     CIMultiplyCompositing         //多层合成
     CIOverlayBlendMode            //覆盖叠加混合模式
     CIRadialGradient              //半径梯度
     CISaturationBlendMode         //饱和度混合模式
     CIScreenBlendMode             //全屏混合模式
     CISepiaTone                   //棕黑色调
     CISoftLightBlendMode          //弱光混合模式
     CISourceAtopCompositing
     CISourceInCompositing
     CISourceOutCompositing
     CISourceOverCompositing
     CIStraightenFilter            //拉直过滤器
     CIStripesGenerator            //条纹发生器
     CITemperatureAndTint          //色温
     CIToneCurve                   //色调曲线
     CIVibrance                    //振动
     CIVignette                    //印花
     CIWhitePointAdjust            //白平衡调节
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
