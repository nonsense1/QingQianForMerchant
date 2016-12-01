//
//  TapImageView.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/23.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapImageView : UIImageView

- (void)addTapBlock:(void(^)(id obj))tapAction;

@end
