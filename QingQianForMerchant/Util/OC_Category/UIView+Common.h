//
//  UIView+Common.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/31.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Common)

//绘制渐变色
- (void)addGradientLayerWithColors:(NSArray *)cgColorsArray locations:(NSArray *)floatNumArray startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
