//
//  UILabel+Common.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/24.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#define LABEL_MAX_HEIGHT 9999
#import "UILabel+Common.h"

@implementation UILabel (Common)

- (void)resizeFrameToFitText {
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize maxSize = CGSizeMake(self.frame.size.width, LABEL_MAX_HEIGHT);
    CGSize exceptSize = [self sizeThatFits:maxSize];
    self.frame = CGRectMake(0, 0, exceptSize.width, exceptSize.height);
}

@end
