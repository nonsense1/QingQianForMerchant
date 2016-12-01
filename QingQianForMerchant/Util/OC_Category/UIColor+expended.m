//
//  UIColor+expended.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/27.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "UIColor+expended.h"

@implementation UIColor (expended)


- (CGFloat)red {
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[1];
}

- (CGFloat)blue {
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[2];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r/255.0f
                           green:g/255.0f
                            blue:b/255.0f
                           alpha:1.0f];
}

#pragma mark Class methods

+ (UIColor *)randomColor {
    return [UIColor colorWithRed:(arc4random()%256)/256.f
                           green:(arc4random()%256)/256.f
                            blue:(arc4random()%256)/256.f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha {
    UIColor *color = [UIColor colorWithHexString:stringToConvert];
    return [UIColor colorWithRed:color.red
                           green:color.green
                            blue:color.blue
                           alpha:alpha];
}



@end
