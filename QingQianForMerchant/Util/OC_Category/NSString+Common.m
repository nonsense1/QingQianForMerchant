//
//  NSString+Common.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/22.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

- (BOOL)isPhoneNo {
    NSString *phoneRegex = @"[0-9]{1,15}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

@end
