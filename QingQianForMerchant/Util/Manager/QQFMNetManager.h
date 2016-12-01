//
//  QQFMNetManager.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/21.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQFMNetManager : NSObject

+ (QQFMNetManager *)sharedManager;

#pragma mark -Login
- (void)loginWithURLString:(NSString *)string
                    Params:(id)params
                  andBlock:(void(^)(id data,NSError *error))block;

- (void)loadShopInfoWithURLString:(NSString *)string
                           params:(id)params
                         andBlock:(void(^)(id data,NSError *error))block;

- (void)sendCaptchaForChangePasswordWithURLString:(NSString *)string
                                           Params:(id)params
                                         andBlock:(void(^)(id data,NSError *error))block;

- (void)changePasswordWithURLString:(NSString *)string
                             Params:(id)params
                           andBlock:(void (^)(id data, NSError *error))block;

#pragma mark -OrderManager

- (void)loadUserInfoWithURLString:(NSString *)string
                           Params:(id)params
                         andBlock:(void(^)(id data,NSError *error))block;


@end
