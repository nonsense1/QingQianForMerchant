//
//  ShopOverview.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/25.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "ShopOverview.h"

@implementation ShopOverview

+ (ShopOverview *)currentShopOverview {
    static ShopOverview *curShop = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        curShop = [[ShopOverview alloc] init];
    });
    return curShop;
}

- (void)setDetailWithShopOverview:(ShopOverview *)shopOverview {
    self.cates = shopOverview.cates;
    self.deduction_rate = shopOverview.deduction_rate;
    self.score = shopOverview.score;
    self.store_id = shopOverview.store_id;
    self.shop_name = shopOverview.shop_name;
    self.photo = shopOverview.photo;
}

- (NSString *)description {
    return[NSString stringWithFormat:@"cates:%@,deduction_rate:%@,score:%ld,shop_name:%@,store_id:%ld,photo:%@",self.cates,self.deduction_rate,(long)self.score,self.shop_name,(long)self.store_id,self.photo];
}

@end
