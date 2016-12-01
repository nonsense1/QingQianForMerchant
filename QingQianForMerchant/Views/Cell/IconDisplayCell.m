//
//  IconDisplayCell.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/23.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "IconDisplayCell.h"
#import "TapImageView.h"
@interface IconDisplayCell ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) TapImageView *accessoryImageView;

@end

@implementation IconDisplayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!_iconView) {
            _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(kPaddingLeftWidth, 11, 22, 22)];
            [self.contentView addSubview:_iconView];
        }
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconView.frame)+10, 12, kScreen_Width/2, 20)];
            _titleLabel.textAlignment = NSTextAlignmentLeft;
            _titleLabel.font = [UIFont systemFontOfSize:15];
            _titleLabel.textColor = [UIColor colorWithHexString:@"0x000000"];
            [self.contentView addSubview:_titleLabel];
        }
    }
    return self;
}

- (void)setTitle:(NSString *)title icon:(NSString *)iconName accessory:(IconCellAccessoryType)accessoryType {
    _titleLabel.text = title;
    _iconView.image = [UIImage imageNamed:iconName];
    switch (accessoryType) {
        case IconCellAccessoryTypeNone:
        {
            
        }
            break;
        case IconCellAccessoryTypeRedArrow:
        {
            if (!_accessoryImageView) {
                _accessoryImageView = [[TapImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentView.frame)-kPaddingRightWidth, 12, 13, 13)];
                _accessoryImageView.image = [UIImage imageNamed:@"accessory_red_arrow"];
                [_accessoryImageView addTapBlock:^(id obj) {
                    
                }];
                [self.contentView addSubview:_accessoryImageView];
            }
        }
            break;
        case IconCellAccessoryTypeGreenArrow:
        {
            if (!_accessoryImageView) {
                _accessoryImageView = [[TapImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentView.frame)-kPaddingRightWidth, 12, 13, 13)];
                _accessoryImageView.image = [UIImage imageNamed:@"accessory_green_arrow"];
                [_accessoryImageView addTapBlock:^(id obj) {
                   
                }];
                [self.contentView addSubview:_accessoryImageView];
            }
        }
            break;
        case IconCellAccessoryTypeCheckMark:
        {
            self.accessoryType = UITableViewCellAccessoryCheckmark;
        }
            break;
        case IconCellAccessoryTypeDetailButton:
        {
            self.accessoryType = UITableViewCellAccessoryDetailButton;
        }
            break;
        case IconCellAccessoryTypeDisclosureIndicator:
        {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        default:
            break;
    }
}

- (void)prepareForReuse {
    
}

+ (CGFloat)cellHeight {
    return 44;
}

@end
