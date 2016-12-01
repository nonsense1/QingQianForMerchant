//
//  StartView.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "StartView.h"
#import <NYXImagesKit/NYXImagesKit.h>
#import "StartImageManager.h"

@interface StartView ()

@property (nonatomic,strong) UIImageView *bgImageView, *logoIconView;
@property (nonatomic,strong) UILabel *descriptionStrLabel;

@end

@implementation StartView

+ (instancetype)startView {
    
    UIImage *logoIcon = [UIImage imageNamed:@""];
    UIImage *st = [UIImage imageNamed:@"STARTIMAGE_0.jpg"];
    NSString *descriptionStr = @"启动页";
    return [[self alloc] initWithBgImage:st logoIcon:logoIcon descriptionStr:descriptionStr];
    
}
- (instancetype)initWithBgImage:(UIImage *)bgImage logoIcon:(UIImage *)logoIcon descriptionStr:(NSString *)descriptionStr {
    if (self = [super initWithFrame:kScreen_Bounds]) {
        UIColor *blackColor = [UIColor blackColor];
        self.backgroundColor = blackColor;
        _bgImageView = [[UIImageView alloc] initWithFrame:kScreen_Bounds];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.alpha = 0.0;
        [self addSubview:_bgImageView];
        
        _logoIconView = [[UIImageView alloc] init];
        _logoIconView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_logoIconView];
        _descriptionStrLabel = [[UILabel alloc] init];
        _descriptionStrLabel.font = [UIFont systemFontOfSize:10];
        _descriptionStrLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _descriptionStrLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionStrLabel.alpha = 0.0;
        [self addSubview:_descriptionStrLabel];
        
        [_descriptionStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@[self,_logoIconView]);
            make.height.mas_equalTo(10);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
        }];
        [_logoIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.mas_equalTo(kScreen_Height/7);
            make.width.mas_equalTo(kScreen_Width*2/3);
            make.height.mas_equalTo(kScreen_Width/4 *2/3);
        }];
        [self configWithBgImage:bgImage logoIcon:logoIcon descriptionStr:descriptionStr];
    }
    return self;
}

- (void)configWithBgImage:(UIImage *)bgImage logoIcon:(UIImage *)logoIcon descriptionStr:(NSString *)descriptionStr {
    self.bgImageView.image = bgImage;
    self.logoIconView.image = logoIcon;
    self.descriptionStrLabel.text = descriptionStr;
    [self updateConstraintsIfNeeded];
}

-(void)startAnimationWithCompletionBlock:(void (^)(StartView *))completionHandler {
    
    [kKeyWindow addSubview:self];
    [kKeyWindow bringSubviewToFront:self];
    _bgImageView.alpha = 0.0;
    _logoIconView.alpha = 0.0;
    @weakify(self);
    [UIView animateWithDuration:2.0 animations:^{
        self.bgImageView.alpha = 1.0;
        self.descriptionStrLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.6 delay:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
           @strongify(self);
           [self setX:-kScreen_Width];
       } completion:^(BOOL finished) {
           @strongify(self);
           [self removeFromSuperview];
           if (completionHandler) {
               completionHandler(self);
           }
       }];
    }];
    
}

@end
