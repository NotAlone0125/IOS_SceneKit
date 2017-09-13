//
//  ViewController.m
//  YYH_SceneKit_SCNScene读写场景文件
//
//  Created by 杨昱航 on 2017/6/27.
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
    
    SCNView * scnView=[[SCNView alloc]initWithFrame:self.view.bounds];

    //加载游戏文件
    scnView.scene=[SCNScene sceneNamed:@"monster.dae"];
    
    [self.view addSubview:scnView];
    
    //将场景写入到文件中去
    NSString * pathString=[NSHomeDirectory() stringByAppendingString:@"/Doucument/monster.dae"];
    [scnView.scene writeToURL:[NSURL fileURLWithPath:pathString] options:nil delegate:nil progressHandler:^(float totalProgress, NSError * _Nullable error, BOOL * _Nonnull stop) {
        NSLog(@"totalProgress----%f",totalProgress);
    }];
    
    NSLog(pathString);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
