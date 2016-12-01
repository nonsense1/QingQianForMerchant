//
//  Shop.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/21.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "Shop.h"

@implementation Shop

+ (Shop *)currentShop {
    static Shop *curShop = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        curShop = [[Shop alloc] init];
    });
    return curShop;
}

- (void)setDetailWithShop:(Shop *)shop {
    self.level = shop.level;
    self.shop_addr = shop.shop_addr;
    self.shop_id = shop.shop_id;
    self.shop_name = shop.shop_name;
    self.shop_photo = shop.shop_photo;
    
    self.store_bank = shop.store_bank;
    self.u_id =shop.u_id;
    self.u_ture_name =  shop.u_ture_name;
    self.user_id = shop.user_id;
    
}



- (NSString *)description {
    return [NSString stringWithFormat:@"level:%ld,shop_addr:%@,shop_id:%ld,shop_name:%@,shop_photo:%@,store_bank:%ld,u_id:%ld,u_ture_name:%ld,user_id:%ld,",(long)self.level,self.shop_addr,(long)self.shop_id,self.shop_name,self.shop_photo,(long)self.store_bank,(long)self.u_id,(long)self.u_ture_name,(long)self.user_id];
}

@end
