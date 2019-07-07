//
//  ModalInteractiveViewController.m
//  Transition
//
//  Created by 杨雄 on 2019/7/5.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "ModalInteractiveViewController.h"
#import "ModalInteractiveTransitionDelegate.h"

@interface ModalInteractiveViewController ()
@property (nonatomic, strong) ModalInteractiveTransitionDelegate *customTransition;
@property (nonatomic, strong) UIButton *dismissButton;

@end

@implementation ModalInteractiveViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 这里给定了转场代理类，设定为UIModalPresentationCustom自定义转场。
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.customTransition = [[ModalInteractiveTransitionDelegate alloc] init];
        self.transitioningDelegate  = self.customTransition;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.dismissButton];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    // 暂时不支持多种屏幕方向的适配。如果需要支持屏幕旋转的话，就需要重新对布局做一些兼容性调整。这里只演示自定义转场，不做复杂处理。
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat nextButton_W = 80.0f;
    CGFloat nextButton_H = 40.0f;
    CGFloat nextButton_X = (self.view.bounds.size.width - nextButton_W) * 0.5;
    CGFloat nextButton_Y = (self.view.bounds.size.height - nextButton_H) - 40;
    CGRect nextButtonFrame = CGRectMake(nextButton_X, nextButton_Y, nextButton_W, nextButton_H);
    self.dismissButton.frame = nextButtonFrame;
}

- (void)panGes:(UIPanGestureRecognizer *)gesture{
    CGFloat yOffset = [gesture translationInView:self.view].y;
    CGFloat percent =  yOffset / 1800;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"begin");
        // 可交互动画开始之前，修改为可交互状态
        self.customTransition.interactive = YES;
        //这句必须加上！！
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        NSLog(@"changed : %f", percent);
        
        [self.customTransition.percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }else if (gesture.state == UIGestureRecognizerStateCancelled ||
              gesture.state == UIGestureRecognizerStateEnded){
        NSLog(@"canceled or ended : %f", percent);
        
        if (percent > 0.15) {
            [self.customTransition.percentDrivenInteractiveTransition finishInteractiveTransition];
        } else{
            [self.customTransition.percentDrivenInteractiveTransition cancelInteractiveTransition];
        }
        
        // 默认修改为不可交互状态
        self.customTransition.interactive = NO;
    }
}

- (void)nextAction:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark setter & getter

- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
        _dismissButton.layer.masksToBounds = YES;
        _dismissButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _dismissButton.layer.borderWidth = 1;
        _dismissButton.layer.cornerRadius = 6;
        [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_dismissButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

@end
