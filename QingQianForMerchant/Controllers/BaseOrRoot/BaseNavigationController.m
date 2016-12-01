//
//  BaseNavigationController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/27.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "BaseNavigationController.h"
#import "PushTransition.h"
#import "PopTranstion.h"
#import "InteractionTransitionAnimation.h"

@interface BaseNavigationController ()
@property (nonatomic, strong) PushTransition *pushAnimation;
@property (nonatomic, strong) PopTranstion *popAnimation;
@property (strong, nonatomic) InteractionTransitionAnimation *popInteraction;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
}


#pragma mark - Navigation delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return self.pushAnimation;
    }else if (operation == UINavigationControllerOperationPop) {
        return self.popAnimation;
    }
    return nil;
    
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.popInteraction.isActing ? self.popInteraction : nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"willShowViewController - %@",self.popInteraction.isActing ?@"YES":@"NO");
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"didShowViewController - %@",self.popInteraction.isActing ?@"YES":@"NO");
}

- (PushTransition *)pushAnimation {
    if (!_pushAnimation) {
        _pushAnimation = [[PushTransition alloc] init];
    }
    return _pushAnimation;
}
-(PopTranstion *)popAnimation
{
    if (!_popAnimation) {
        _popAnimation = [[PopTranstion alloc] init];
    }
    return _popAnimation;
}
- (InteractionTransitionAnimation *)popInteraction {
    if (!_popInteraction) {
        _popInteraction = [[InteractionTransitionAnimation alloc] init];

    }
    return _popInteraction;
}
@end
