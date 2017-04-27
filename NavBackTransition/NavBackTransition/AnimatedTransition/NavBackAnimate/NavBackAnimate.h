//
//  NavBackAnimate.h
//  NavBackTransition
//
//  Created by ZHK on 2017/4/27.
//  Copyright © 2017年 Weiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavBackAnimate : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)animationWithOperation:(UINavigationControllerOperation)operation;

@end
