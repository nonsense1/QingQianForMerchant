//
//  UITableView+Common.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/2.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Common)

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;
- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine;

@end
