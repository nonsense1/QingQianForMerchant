//
//  PhoneCodeButton.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/1.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "PhoneCodeButton.h"

@interface PhoneCodeButton ()

@property (nonatomic, strong, readwrite) NSTimer *timer;
@property (assign, nonatomic) NSTimeInterval durationToValidity;
@end

@implementation PhoneCodeButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.clipsToBounds = YES;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = frame.size.height/4;
        self.enabled = YES;
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    UIColor *foreColor = [UIColor colorWithHexString:@"0xf61d4a" andAlpha:enabled ? 1.0 : 0.5];
    [self setTitleColor:foreColor forState:UIControlStateNormal];
    self.layer.borderColor = foreColor.CGColor;
    if (enabled) {
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
    }else if ([self.titleLabel.text isEqualToString:@"发送验证码"]){
        [self setTitle:@"正在发送..." forState:UIControlStateNormal];
    }
}

- (void)startUpTimer {
    _durationToValidity = 60;
    if (self.isEnabled) {
        self.enabled = NO;
    }
    [self setTitle:[NSString stringWithFormat:@"%.f 秒",_durationToValidity] forState:UIControlStateNormal];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(redrawTimer:) userInfo:nil repeats:YES];
}

- (void)invalidateTimer {
    if (!self.isEnabled) {
        self.enabled = YES;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (void)redrawTimer:(NSTimer *)timer {
    _durationToValidity--;
    if (_durationToValidity > 0) {
//        self.titleLabel.text = [NSString stringWithFormat:@"%.0f 秒", _durationToValidity];//防止 button_title 闪烁
        [self setTitle:[NSString stringWithFormat:@"%.0f 秒", _durationToValidity] forState:UIControlStateNormal];
    }else {
        [self invalidateTimer];
    }
}

@end
