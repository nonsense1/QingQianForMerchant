//
//  InteractionTransitionAnimation.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/3.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "InteractionTransitionAnimation.h"

@interface InteractionTransitionAnimation ()<UIGestureRecognizerDelegate>
@property (assign, nonatomic) BOOL canReceive;
@property (strong, nonatomic) UIViewController *remVC;
@end

@implementation InteractionTransitionAnimation

- (void)writeToViewController:(UIViewController *)viewController {
    self.remVC = viewController;
    [self addPanGestureRecognizerToView:viewController.view];
}

- (void)addPanGestureRecognizerToView:(UIView *)view {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecongnizer:)];
    pan.delegate = self;
    [view addGestureRecognizer:pan];
}

- (void)panRecongnizer:(UIPanGestureRecognizer *)pan {
    CGPoint panPoint = [pan translationInView:pan.view.superview];
    CGPoint locationPoint = [pan locationInView:pan.view.superview];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.isActing = YES;
        if (locationPoint.y <= self.remVC.view.bounds.size.height/2.0) {
            [self.remVC.navigationController popViewControllerAnimated:YES];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        if (locationPoint.y >= self.remVC.view.bounds.size.height/2.0) {
            self.canReceive = YES;
        }else {
            self.canReceive = NO;
        }
        [self updateInteractiveTransition:panPoint.y/self.remVC.view.bounds.size.height ];
    }else if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded) {
        self.isActing = NO;
        if (!self.canReceive || pan.state == UIGestureRecognizerStateCancelled) {
            [self cancelInteractiveTransition];
        }else {
            [self finishInteractiveTransition];
        }
    }
}

//有tableview时也能响应手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}

@end
