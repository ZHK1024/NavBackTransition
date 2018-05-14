//
//  NavBackAnimate.m
//  NavBackTransition
//
//  Created by ZHK on 2017/4/27.
//  Copyright © 2017年 Weiyu. All rights reserved.
//

#import "NavBackAnimate.h"
#import "BaseViewController.h"

#define Duration .35f

@interface NavBackAnimate ()

@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation NavBackAnimate

#pragma mark - Init

+ (instancetype)animationWithOperation:(UINavigationControllerOperation)operation {
    NavBackAnimate *animation = [self new];
    animation.operation = operation;
    return animation;
}

#pragma mark -

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return Duration;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    BaseViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // nav 背景是否需要过渡动画(颜色不同则需要,否则不需要)
    BOOL navBackNeedTransition = ![fromVC.navBackColor_zhk isEqual:toVC.navBackColor_zhk];
    
    UIView *containerView = [transitionContext containerView];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
//    fromVC.view.hidden = YES;
    
//    imageView.backgroundColor = [UIColor redColor];
    
    if (_operation == UINavigationControllerOperationPush) {
        
        [containerView addSubview:imageView];
        [containerView addSubview:toVC.view];
        
        imageView.image = [self snapshot:fromVC.view];
        imageView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
        toVC.view.frame = CGRectMake(screenSize.width, 0, screenSize.width, screenSize.height);
        
        toVC.view.layer.shadowColor = [UIColor grayColor].CGColor;
        toVC.view.layer.shadowOffset = CGSizeMake(-3, 0);
        toVC.view.layer.shadowOpacity = .5;
        
    } else if (_operation == UINavigationControllerOperationPop) {
        
        [containerView addSubview:toVC.view];
        [containerView addSubview:imageView];
        
        imageView.image = [self snapshot:fromVC.view];
        imageView.frame = fromVC.view.bounds;
        toVC.view.frame = CGRectMake(-screenSize.width / 3, 0, screenSize.width, screenSize.height);
        
        imageView.layer.shadowColor = [UIColor grayColor].CGColor;
        imageView.layer.shadowOffset = CGSizeMake(-3, 0);
        imageView.layer.shadowOpacity = .5;
    } else {
        NSLog(@"");
    }
    
    UIView *backView = nil;
    if (navBackNeedTransition) {
        
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 64)];
        backView.backgroundColor = fromVC.navBackColor_zhk;
        [containerView addSubview:backView];
    }
    
    [UIView animateWithDuration:Duration animations:^{
        if (_operation == UINavigationControllerOperationPush) {
            
            imageView.frame = CGRectMake(-screenSize.width / 3, 0, screenSize.width, screenSize.height);
            toVC.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
            
        }else if (_operation == UINavigationControllerOperationPop) {
            
            imageView.frame = CGRectMake(screenSize.width, 0, screenSize.width, screenSize.height);
            toVC.view.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
            
        }
        backView.backgroundColor = toVC.navBackColor_zhk;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [imageView removeFromSuperview];
        [backView removeFromSuperview];
//        fromVC.view.hidden = NO;
    }];
    
}

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
- (void)animationEnded:(BOOL) transitionCompleted {
    
}

#pragma mark - 

- (UIImage *)snapshot:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    
    BOOL success = [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    if (!success) {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
