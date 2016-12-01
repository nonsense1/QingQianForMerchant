//
//  InteractionTransitionAnimation.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/3.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InteractionTransitionAnimation : UIPercentDrivenInteractiveTransition
@property (assign, nonatomic) BOOL isActing;

- (void)writeToViewController:(UIViewController *)viewController;

@end
