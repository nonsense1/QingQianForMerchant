//
//  AppDelegate.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/21.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//




@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

