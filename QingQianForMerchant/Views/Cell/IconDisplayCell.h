//
//  IconDisplayCell.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/23.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//
#define kCellIdentifier_IconDisplayCell @"IconDisplayCell"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,IconCellAccessoryType) {
    IconCellAccessoryTypeNone = 0,
    IconCellAccessoryTypeGreenArrow,
    IconCellAccessoryTypeRedArrow,
    IconCellAccessoryTypeDisclosureIndicator,
    IconCellAccessoryTypeCheckMark,
    IconCellAccessoryTypeDetailButton,
};

@interface IconDisplayCell : UITableViewCell

- (void)setTitle:(NSString *)title icon:(NSString *)iconName accessory:(IconCellAccessoryType)accessoryType;
+ (CGFloat)cellHeight;

@end
