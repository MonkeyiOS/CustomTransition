//
//  ModalNormalViewController.m
//  Transition
//
//  Created by 杨雄 on 2019/7/4.
//  Copyright © 2019 shawn. All rights reserved.
//

#import "ModalNormalViewController.h"
#import "ModalNormalTransitionDelegate.h"

@interface ModalNormalViewController ()
@property (nonatomic, strong) ModalNormalTransitionDelegate *customTransition;
@property (nonatomic, strong) UIButton *dismissButton;

@end

@implementation ModalNormalViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self.view removeObserver:self forKeyPath:@"frame"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 这里给定了转场代理类，设定为UIModalPresentationCustom自定义转场。
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.customTransition = [[ModalNormalTransitionDelegate alloc] init];
        self.transitioningDelegate  = self.customTransition;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:self.dismissButton];
    /**
     * 因为我演示的自定义转场动画改变了toView的尺寸，所以子控件在viewWillLayoutSubview里面布局的话会有一些展示问题。
     * 通过KVO在这里布局能实时保证子控件是严格相对父控件的。
     * 可以自己验证一下在viewWillLayoutSubview里布局的效果。
     */
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    // 暂时不支持多种屏幕方向的适配。如果需要支持屏幕旋转的话，就需要重新对布局做一些兼容性调整。这里只演示自定义转场，不做复杂处理。
    return UIInterfaceOrientationMaskPortrait;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object == self.view && [keyPath isEqualToString:@"frame"]) {
        CGFloat nextButton_W = 80.0f;
        CGFloat nextButton_H = 40.0f;
        CGFloat nextButton_X = (self.view.bounds.size.width - nextButton_W) * 0.5;
        CGFloat nextButton_Y = (self.view.bounds.size.height - nextButton_H) - 40;
        CGRect nextButtonFrame = CGRectMake(nextButton_X, nextButton_Y, nextButton_W, nextButton_H);
        self.dismissButton.frame = nextButtonFrame;
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
