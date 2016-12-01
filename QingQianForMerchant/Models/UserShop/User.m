//
//  User.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/25.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)currentUser {
    static User *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    return user;
}

- (void)setUserDetail:(User *)user {
    self.mobile = user.mobile;
    self.face = user.face;
    self.nickname = user.nickname;
    self.store_bank_flg = user.store_bank_flg;
    self.store_id = user.store_id;
    self.store_last_getmoney_time = user.store_last_getmoney_time;
    self.store_money_accumulatie = user.store_money_accumulatie;
    self.store_score_power = user.store_score_power;
    self.store_score_power_accumulatie = user.store_score_power_accumulatie;
    self.u_id = user.u_id;
    self.reserve_fund = user.reserve_fund;
    self.reserve_fund_accumulatie = user.reserve_fund_accumulatie;
    self.store_score = user.store_score;
    self.store_score_accumulatie = user.store_score_accumulatie;
    self.store_sell_accumulatie = user.store_sell_accumulatie;
}

@end
