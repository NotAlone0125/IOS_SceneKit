//
//  ViewController.h
//  YYH_SceneKit_灯光
//
//  Created by 杨昱航 on 2017/6/27.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 光的介绍
  环境光(SCNLightTypeAmbient):没有方向，位置在无穷远处，光均匀的散射到物体上。
  点光源(SCNLightTypeOmni):有固定的位置，方向360度，可以衰减。
  平行方向光(SCNLightTypeDirectional):只有照射的方向，没有位置，不会衰减。
  环境光(SCNLightTypeSpot):光源有固定的位置，也有方向，也有照射区域，可以衰减。
 */

@interface ViewController : UIViewController


@end

