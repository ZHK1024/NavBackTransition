//
//  BaseViewController.m
//  NavBackTransition
//
//  Created by ZHK on 2017/4/27.
//  Copyright © 2017年 Weiyu. All rights reserved.
//

#import "BaseViewController.h"
#import "NavBackAnimate.h"

@interface BaseViewController () <UINavigationControllerDelegate>

// 导航栏背景视图
@property (nonatomic, strong) UIView *navBackView_zhk;
// 交互动画控制对象(主要用于全屏手势返回过程动画的控制)
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition_zhk;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.navBackView_zhk = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 64)];
    [self.view addSubview:_navBackView_zhk];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_zhk_popGestureAction:)];
    [self.view addGestureRecognizer:pan];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:_navBackView_zhk];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

- (void)_zhk_popGestureAction:(UIPanGestureRecognizer *)pan {
    // 计算动画进度百分比
    CGFloat offset = [pan translationInView:self.view].x;
    CGFloat progress = offset / [UIScreen mainScreen].bounds.size.width;
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition_zhk = [[UIPercentDrivenInteractiveTransition alloc] init];
        // pop
        [self.navigationController popViewControllerAnimated:YES];
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        // 更新动画进度
        [_interactiveTransition_zhk updateInteractiveTransition:progress];
    }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        // 大于 50% 完成过渡动画, 否则取消
        if (progress > 0.5) {
            [_interactiveTransition_zhk finishInteractiveTransition];
        }else {
            [_interactiveTransition_zhk cancelInteractiveTransition];
        }
        self.interactiveTransition_zhk = nil;
    }
}

#pragma mark - UINavigationController delegate

// 返回交互过渡动画控制对象
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    return _interactiveTransition_zhk;
}

// 返回过渡动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  {
    return [NavBackAnimate animationWithOperation:operation];
}

#pragma mark - Setter

- (void)setNavBackColor_zhk:(UIColor *)navBackColor_zhk {
    if (_navBackColor_zhk != navBackColor_zhk) {
        _navBackColor_zhk = navBackColor_zhk;
        _navBackView_zhk.backgroundColor = _navBackColor_zhk;
    }
}

@end
