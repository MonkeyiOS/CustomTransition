//
//  ModalInteractivePresentationController.m
//  Transition
//
//  Created by 杨雄 on 2019/7/5.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "ModalInteractivePresentationController.h"

@interface ModalInteractivePresentationController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation ModalInteractivePresentationController

- (void)presentationTransitionWillBegin {
    // 添加背景图，并执行动画
    //创建视图
    self.bgView = [[UIView alloc] init];
    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    [self.bgView addSubview:self.blurView];
    
    if (@available(iOS 11, *)) {
        // 不处理
    } else {
        // 这里是 iOS 11 之前的系统bug。当可交互转场取消的时候，不添加下面代码会造成黑屏。
        [self.containerView addSubview:self.presentingViewController.view];
    }
    
    [self.containerView addSubview:self.bgView];
    
    // 转场协调器，用来将这里修改UI部分的代码和转场动画控制器里面的代码按照同样的动画方式同步执行。
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    // 默认不透明
    self.bgView.alpha = 0.0;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.bgView.alpha = 0.7;
        // 这里不能直接给view做变换，只能给layer做变换。给view做变换，tableView界面会异常滚动，不知原因。
        self.presentingViewController.view.layer.affineTransform = CGAffineTransformScale(self.presentingViewController.view.layer.affineTransform, 0.92, 0.92);
    } completion:nil];
    
    self.presentedView.layer.cornerRadius = 8;
}

- (void)containerViewWillLayoutSubviews {
    // 布局自定义控件
    self.bgView.frame = self.containerView.bounds;
    self.blurView.frame = self.bgView.bounds;
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    //如果呈现没有完成，那就移除添加上的子控件
    if (!completed) {
        [self.bgView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    // 执行消失的动画
    // 与过渡效果一起执行背景 View 的淡出效果
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.bgView.alpha = 0;
        // 这里不能直接给view做变换，只能给layer做变换。给view做变换，tableView界面会异常滚动，不知原因。
        self.presentingViewController.view.layer.affineTransform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    // 处理版本兼容问题
    if (@available(iOS 11, *)) {
        // 不处理
    } else {
        // 这里是 iOS 11 之前的系统bug。当可交互转场取消的时候，不添加下面代码会造成黑屏。
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.presentingViewController.view];
    }
}

@end
