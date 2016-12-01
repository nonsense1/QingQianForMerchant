//
//  BaseViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/27.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)showMessage:(NSString *)message withDuring:(NSTimeInterval)during{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:during];
    hud.completionBlock = ^{
        NSLog(@"HUD Has Been Hiden!");
    };
}

- (void)customizeInterface {
    UINavigationBar *navBarApperance = [UINavigationBar appearance];
    [navBarApperance setBackgroundImage:[UIImage imageWithColor:kColorNavBG] forBarMetrics:UIBarMetricsDefault];
    [navBarApperance setTintColor:kColorBrandGreen];
    NSDictionary *textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:kNavTitleFontSize],
                                     NSForegroundColorAttributeName:kColorNavTitle,};
    [navBarApperance setTitleTextAttributes:textAttributes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeInterface];
}



@end
