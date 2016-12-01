//
//  QQFMWebViewController.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/23.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>
@interface QQFMWebViewController : BaseViewController


- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithAddress:(NSString *)urlString;
- (instancetype)initWithURLRequest:(NSURLRequest *)request;



@end
