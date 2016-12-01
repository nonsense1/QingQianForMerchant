//
//  NSURL+Common.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/25.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Common)

+ (NSURL *)URLWithImageLow:(NSString *)imageString;
+ (NSURL *)URLWithImagemedium:(NSString *)imageString;
+ (NSURL *)URLWithImagespecial:(NSString *)imageString;
+ (NSURL *)URLWithImagehigh:(NSString *)imageString;

@end
