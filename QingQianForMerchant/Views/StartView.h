//
//  StartView.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartView : UIView
+ (instancetype)startView;
- (void)startAnimationWithCompletionBlock:(void(^)(StartView *startview))completionHandler;

@end
