//
//  ModalInteractiveTransitionDelegate.h
//  Transition
//
//  Created by 杨雄 on 2019/7/5.
//  Copyright © 2019 shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModalInteractiveTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>
/**
 交互控制器
 */
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentDrivenInteractiveTransition;

/**
 是否可交互
 */
@property (nonatomic, assign, getter=isInteractive) BOOL interactive;

@end

NS_ASSUME_NONNULL_END
