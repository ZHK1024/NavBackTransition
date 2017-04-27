//
//  ViewController.m
//  NavBackTransition
//
//  Created by ZHK on 2017/4/27.
//  Copyright © 2017年 Weiyu. All rights reserved.
//

#import "ViewController.h"

#define COLOR_66CCFF [UIColor colorWithRed:102 / 255.0 green:204 / 255.0 blue:255 / 255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBackColor_zhk = COLOR_66CCFF;
    self.title = @"首页";
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
