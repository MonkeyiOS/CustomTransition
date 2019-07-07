//
//  ModalInteractiveTransitionDelegate.m
//  Transition
//
//  Created by 杨雄 on 2019/7/5.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "ModalInteractiveTransitionDelegate.h"
#import "ModalInteractiveAnimatedPresentation.h"
#import "ModalInteractivePresentationController.h"

@implementation ModalInteractiveTransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    ModalInteractiveAnimatedPresentation *animatedPresentation = [[ModalInteractiveAnimatedPresentation alloc] init];
    return animatedPresentation;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    ModalInteractivePresentationController *presentationController = [[ModalInteractivePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return presentationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    // 当需要手势转场的时候才返回交互控制器
    if (self.isInteractive) {
        return self.percentDrivenInteractiveTransition;
    } else {
        return nil;
    }
}

- (UIPercentDrivenInteractiveTransition *)percentDrivenInteractiveTransition {
    if (!_percentDrivenInteractiveTransition) {
        _percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return _percentDrivenInteractiveTransition;
}

@end
