//
//  UIBarButtonItem+Common.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/1.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "UIBarButtonItem+Common.h"

@implementation UIBarButtonItem (Common)
+ (UIBarButtonItem *)itemWithBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector {
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:obj action:selector];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xffffff"]} forState:UIControlStateNormal];
    return buttonItem;
}
@end
