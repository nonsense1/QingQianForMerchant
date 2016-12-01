//
//  Login.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "Login.h"
#define kLogin_Username @"login_username"
#define kLogin_Password @"login_password"

@interface Login ()
@property (nonatomic, strong) Login *login;
@end

@implementation Login

- (instancetype)init {
    if (self = [super init]) {
        self.userName = @"";
        self.password = @"";
    }
    return self;
}

+ (BOOL)isLogin {
    return NO;
}

- (void)saveLoginInfo {
    [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:kLogin_Username];
    [[NSUserDefaults standardUserDefaults] setObject:self.password forKey:kLogin_Password];
}

- (Login *)readLoginInfo {
    self.login = [[Login alloc] init];
    self.login.userName = [[NSUserDefaults standardUserDefaults] objectForKey:kLogin_Username];
//    self.login.password = [[NSUserDefaults standardUserDefaults] objectForKey:kLogin_Password];
    return self.login;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"username:%@,password:%@",self.userName,self.password];
}

@end
