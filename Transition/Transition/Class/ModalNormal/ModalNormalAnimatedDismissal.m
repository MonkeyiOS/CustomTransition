//
//  ModalNormalAnimatedDismissal.m
//  Transition
//
//  Created by 杨雄 on 2019/7/4.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "ModalNormalAnimatedDismissal.h"

@implementation ModalNormalAnimatedDismissal

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    
    if ([fromVC isBeingDismissed]) {
        // Modal转场的custom模式下，vc不会被销毁，所以这里不需要把fromVC再添加一次
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 动画完成后的位置
            CGFloat fromView_W = 50;
            CGFloat fromView_H = 50;
            CGFloat fromView_X = ([UIScreen mainScreen].bounds.size.width - fromView_W) * 0.5;
            CGFloat fromView_Y = ([UIScreen mainScreen].bounds.size.height - fromView_H) * 0.5;
            CGRect fromViewFrame = CGRectMake(fromView_X, fromView_Y, fromView_W, fromView_H);
            fromView.frame = fromViewFrame;
            
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            // 动画结束后，判断转场是否是被取消的，需要通知转场上下文环境类是否完成了转场。一般情况非交互转场不会出现cancelled的状态，交互式才会有。
            BOOL isCancelled = transitionContext.transitionWasCancelled;
            [transitionContext completeTransition:!isCancelled];
        }];
    }
}

@end
