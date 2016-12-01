//
//  Shop.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/21.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject

@property (assign, nonatomic) NSInteger level;
@property (strong, nonatomic) NSString *shop_addr;
@property (assign, nonatomic) NSInteger shop_id;
@property (strong, nonatomic) NSString *shop_photo;
@property (strong, nonatomic) NSString *shop_name;
@property (assign, nonatomic) NSInteger store_bank;
@property (assign, nonatomic) NSInteger u_id;
@property (assign, nonatomic) NSInteger u_ture_name;
@property (assign, nonatomic) NSInteger user_id;


+ (Shop *)currentShop;

- (void)setDetailWithShop:(Shop *)shop;

@end
