//
//  UIColor+expended.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/27.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (expended)

@property (nonatomic,readonly) CGFloat red;
@property (nonatomic,readonly) CGFloat green;
@property (nonatomic,readonly) CGFloat blue;

+ (UIColor *)randomColor;
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

@end
