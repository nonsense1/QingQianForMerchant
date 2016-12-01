//
//  Login.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

@property (readwrite,nonatomic,strong) NSString *userName, *password;

+ (BOOL)isLogin;

- (void)saveLoginInfo;

- (Login *)readLoginInfo;

@end
