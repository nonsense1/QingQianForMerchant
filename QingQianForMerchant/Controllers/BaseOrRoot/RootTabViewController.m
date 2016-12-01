//
//  RootTabViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/27.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "RootTabViewController.h"
#import "Order_RootViewController.h"
#import "Commodity_RootViewController.h"
#import "Comment_RootViewController.h"
#import "Shop_RootViewController.h"
#import "BaseNavigationController.h"
#import "RDVTabBarItem.h"

@interface RootTabViewController ()

@end

@implementation RootTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    
    Order_RootViewController *order = [[Order_RootViewController alloc] init];
    UINavigationController *nav_order = [[BaseNavigationController alloc] initWithRootViewController:order];
    
    Commodity_RootViewController *commodity = [[Commodity_RootViewController alloc] init];
    UINavigationController *nav_commodity = [[BaseNavigationController alloc] initWithRootViewController:commodity];
    
    Comment_RootViewController *comment = [[Comment_RootViewController alloc] init];
    UINavigationController *nav_comment = [[BaseNavigationController alloc] initWithRootViewController:comment];
    
    Shop_RootViewController *shop = [[Shop_RootViewController alloc] init];
    UINavigationController *nav_shop = [[BaseNavigationController alloc] initWithRootViewController:shop];
    
    [self setViewControllers:@[nav_order,nav_commodity,nav_comment,nav_shop]];
    [self customizeTabbarForController];
    self.delegate = self;
}


/**********************************************************************
 *                     tabbar图片内容大小不一致                          *
 **********************************************************************/
- (void)customizeTabbarForController {
    
    UIImage *backgroundImage = [UIImage imageWithColor:kColorTabBG];
    NSArray *tabBarItemImages = @[@"order_tabbar", @"commodify_tabbar", @"comment_tabbar", @"shop_tabbar"];
    NSArray *tabBarItemTitles = @[@"订单管理", @"商品管理", @"评价管理", @"店铺管理"];
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        item.titlePositionAdjustment = UIOffsetMake(0, 3);
        [item setBackgroundSelectedImage:backgroundImage
                     withUnselectedImage:backgroundImage];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",[tabBarItemImages objectAtIndex:index]]];
        UIImage *unSelectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",[tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unSelectedImage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        
        index ++;
    }
    
}

#pragma mark RDVTabBarControllerDelegate


@end
