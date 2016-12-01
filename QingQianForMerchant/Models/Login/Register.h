//
//  Register.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/1.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Register : NSObject

@property (readwrite,nonatomic,strong) NSString *email, *captcha, *phone, *password, *compPassword, *isAgree;

@end
