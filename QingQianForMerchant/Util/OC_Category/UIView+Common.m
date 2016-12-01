//
//  UIView+Common.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/31.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)

- (void)addGradientLayerWithColors:(NSArray *)cgColorsArray locations:(NSArray *)floatNumArray startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.frame;
    if (cgColorsArray && [cgColorsArray count] > 0) {
        layer.colors = cgColorsArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorsArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
    
}

@end
