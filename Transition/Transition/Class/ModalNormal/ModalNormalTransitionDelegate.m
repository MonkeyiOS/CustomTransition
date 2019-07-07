//
//  ModalNormalTransitionDelegate.m
//  Transition
//
//  Created by 杨雄 on 2019/7/4.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "ModalNormalTransitionDelegate.h"
#import "ModalNormalAnimatedPresentation.h"
#import "ModalNormalAnimatedDismissal.h"
#import "ModalNormalPresentationController.h"

@implementation ModalNormalTransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    ModalNormalAnimatedPresentation *presentationAnimation = [[ModalNormalAnimatedPresentation alloc] init];
    return presentationAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {    
    ModalNormalAnimatedDismissal *dismissedAnimation = [[ModalNormalAnimatedDismissal alloc] init];
    return dismissedAnimation;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    ModalNormalPresentationController *presentationController = [[ModalNormalPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return presentationController;
}

@end
