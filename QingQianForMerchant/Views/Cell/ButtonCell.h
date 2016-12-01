//
//  ButtonCell.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/24.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//
#define kCellIdentifier_ButtonCell @"ButtonCell"
#import <UIKit/UIKit.h>

@interface ButtonCell : UITableViewCell

- (void)setButtonSize:(CGSize)size titles:(NSArray *)titles clolors:(NSArray *)colors target:(id)target addActions:(NSArray *)action;

+ (CGFloat)cellHeight;

@end
