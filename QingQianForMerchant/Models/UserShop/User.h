//
//  User.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/25.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (assign, nonatomic) NSUInteger mobile;
@property (strong, nonatomic) NSString *face;
@property (strong, nonatomic) NSString *nickname;
@property (assign, nonatomic) NSInteger store_bank_flg;
@property (assign, nonatomic) NSInteger store_id;
@property (assign, nonatomic) NSInteger store_last_getmoney_time;
@property (assign, nonatomic) NSInteger store_money_accumulatie;
@property (assign, nonatomic) NSInteger store_score_power;
@property (assign, nonatomic) NSInteger store_score_power_accumulatie;
@property (assign, nonatomic) NSInteger u_id;
@property (strong, nonatomic) NSString *reserve_fund;
@property (strong, nonatomic) NSString *reserve_fund_accumulatie;
@property (strong, nonatomic) NSString *store_score;
@property (strong, nonatomic) NSString *store_score_accumulatie;
@property (strong, nonatomic) NSString *store_sell_accumulatie;

+ (User *)currentUser;

- (void)setUserDetail:(User *)user;

@end
