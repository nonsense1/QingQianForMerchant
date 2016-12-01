//
//  NSURL+Common.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/25.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "NSURL+Common.h"

@implementation NSURL (Common)

+ (NSURL *)URLWithImageLow:(NSString *)imageString {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://img.lsxfpt.com/attachs/%@@!WAPMOBILElow",imageString]];
}
+ (NSURL *)URLWithImagemedium:(NSString *)imageString {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://img.lsxfpt.com/attachs/%@@!WAPMOBILEmedium",imageString]];
}

+ (NSURL *)URLWithImagespecial:(NSString *)imageString {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://img.lsxfpt.com/attachs/%@@!WAPMOBILEspecial",imageString]];
}

+ (NSURL *)URLWithImagehigh:(NSString *)imageString {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://img.lsxfpt.com/attachs/%@@!WAPMOBILEhigh",imageString]];
}

@end
