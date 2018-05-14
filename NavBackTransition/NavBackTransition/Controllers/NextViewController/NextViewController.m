//
//  NextViewController.m
//  NavBackTransition
//
//  Created by ZHK on 2017/4/27.
//  Copyright © 2017年 Weiyu. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navBackColor_zhk = [UIColor orangeColor];
    self.title = @"第二页";

    self.navigationItem.leftBarButtonItem = ({
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_img"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
