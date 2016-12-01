//
//  ShopOverview.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/25.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopOverview : NSObject

@property (strong, nonatomic) NSString *cates;
@property (strong, nonatomic) NSString *deduction_rate;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) NSInteger store_id;
@property (strong, nonatomic) NSString *shop_name;
@property (strong, nonatomic) NSString *photo;


+ (ShopOverview *)currentShopOverview;

- (void)setDetailWithShopOverview:(ShopOverview *)shopOverview;

@end
