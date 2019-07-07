//
//  ModalNormalAnimatedPresentation.m
//  Transition
//
//  Created by 杨雄 on 2019/7/4.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "ModalNormalAnimatedPresentation.h"

@implementation ModalNormalAnimatedPresentation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    if ([toVC isBeingPresented]) {
        [containerView addSubview:toView];
        
        // 初始位置
        CGFloat toView_W = 50;
        CGFloat toView_H = 50;
        CGFloat toView_X = ([UIScreen mainScreen].bounds.size.width - toView_W) * 0.5;
        CGFloat toView_Y = ([UIScreen mainScreen].bounds.size.height - toView_H) * 0.5;
        CGRect toViewFrame = CGRectMake(toView_X, toView_Y, toView_W, toView_H);
        toView.frame = toViewFrame;
        
        toView.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            // 动画完成后的位置
            CGFloat toView_W = 200;
            CGFloat toView_H = 300;
            CGFloat toView_X = ([UIScreen mainScreen].bounds.size.width - toView_W) * 0.5;
            CGFloat toView_Y = ([UIScreen mainScreen].bounds.size.height - toView_H) * 0.5;
            CGRect toViewFrame = CGRectMake(toView_X, toView_Y, toView_W, toView_H);
            toView.frame = toViewFrame;
            
            toView.alpha = 1;
        } completion:^(BOOL finished) {
            // 动画结束后，判断转场是否是被取消的，需要通知转场上下文环境类是否完成了转场。一般情况非交互转场不会出现cancelled的状态，交互式才会有。
            BOOL isCancelled = transitionContext.transitionWasCancelled;
            [transitionContext completeTransition:!isCancelled];
        }];
    }
}

@end
