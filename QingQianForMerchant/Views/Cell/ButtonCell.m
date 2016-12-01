//
//  ButtonCell.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/24.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "ButtonCell.h"

@interface ButtonCell ()

@end

@implementation ButtonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.frame = self.bounds;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setButtonSize:(CGSize)size titles:(NSArray *)titles clolors:(NSArray *)colors target:(id)target addActions:(NSArray *)action{
    NSInteger count = titles.count;
    for (int i = 0; i < count; i++) {
        
        NSString *sel = action[i];
        SEL action = NSSelectorFromString(sel);
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setBackgroundColor:colors[i]];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = size.height/5;
        button.clipsToBounds = YES;
        [self.contentView addSubview:button];
        if (count == 1) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                make.centerY.equalTo(self.contentView);
                make.centerX.mas_equalTo(self.contentView.frame.origin.x/2);
            }];
        }
        if (count % 2 == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                make.centerY.equalTo(self.contentView);
                make.centerX.mas_equalTo(self.contentView.frame.origin.x/2-((count-1)-2*i)*(size.width+10)/2);
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                make.centerY.equalTo(self.contentView);
                make.centerX.mas_equalTo(self.contentView.frame.origin.x/2-(count-2-i)*(size.width+10));
            }];
        }
    }
}

+ (CGFloat)cellHeight {
    return 44;
}

@end
