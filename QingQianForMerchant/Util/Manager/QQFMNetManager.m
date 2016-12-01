//
//  QQFMNetManager.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/21.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "QQFMNetManager.h"
#import "QQFMNetClient.h"

#import "Shop.h"
#import "ShopOverview.h"
#import "User.h"

@implementation QQFMNetManager

+ (QQFMNetManager *)sharedManager {
    static QQFMNetManager *sharedmanager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedmanager = [[self alloc] init];
    });
    return sharedmanager;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

#pragma mark -Login
- (void)loginWithURLString:(NSString *)string  Params:(id)params andBlock:(void (^)(id, NSError *))block {
    
    [[QQFMNetClient sharedClient] requestWithURLString:string parameters:params type:HttpRequestTypeGet progress:nil success:^(id  _Nullable responseObject) {
        
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
         DebugLog(@"%@",dic);
        [[Shop currentShop] setDetailWithShop:[Shop yy_modelWithDictionary:dic[@"data"]]];
        block(dic,nil);
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)loadShopInfoWithURLString:(NSString *)string params:(id)params andBlock:(void (^)(id, NSError *))block {
    [[QQFMNetClient sharedClient] requestWithURLString:string parameters:params type:HttpRequestTypeGet success:^(id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        DebugLog(@"%@",dic);
        [[ShopOverview currentShopOverview] setDetailWithShopOverview:[ShopOverview yy_modelWithDictionary:dic[@"msg"]]];
        block(dic,nil);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)sendCaptchaForChangePasswordWithURLString:(NSString *)string Params:(id)params andBlock:(void (^)(id, NSError *))block {
    [[QQFMNetClient sharedClient] requestWithURLString:string parameters:params type:HttpRequestTypePost success:^(id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        DebugLog(@"%@",dic);
        block(dic,nil);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)changePasswordWithURLString:(NSString *)string Params:(id)params andBlock:(void (^)(id, NSError *))block {
    [[QQFMNetClient sharedClient] requestWithURLString:string parameters:params type:HttpRequestTypePost success:^(id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        
        block(dic,nil);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -OrderManager
- (void)loadUserInfoWithURLString:(NSString *)string Params:(id)params andBlock:(void (^)(id, NSError *))block {
    [[QQFMNetClient sharedClient] requestWithURLString:string parameters:params type:HttpRequestTypeGet success:^(id  _Nullable responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        [[User currentUser] setUserDetail:[User yy_modelWithDictionary:dic[@"users"][@"0"]]];
        block(dic,nil);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
