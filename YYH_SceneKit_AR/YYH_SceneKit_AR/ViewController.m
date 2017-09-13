//
//  ViewController.m
//  YYH_SceneKit_AR
//
//  Created by 杨昱航 on 2017/7/4.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arView=[[ARView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:arView];
    
    NSURL * url=[[NSBundle mainBundle] URLForResource:@"boss_attack" withExtension:@"dae"];
    [arView ARViewWithModelFile:url position:SCNVector3Make(0, 100, -1000)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
