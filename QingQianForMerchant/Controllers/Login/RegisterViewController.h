//
//  RegisterViewController.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/1.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "BaseViewController.h"
#import "Register.h"

typedef NS_ENUM(NSInteger,RegisterMethodType) {
    RegisterMethodEmail = 0,
    RegisterMethodPhone,
};

@interface RegisterViewController : BaseViewController

+ (instancetype)vcWithMethodType:(RegisterMethodType)methodType registerObj:(Register *)obj;

@end
