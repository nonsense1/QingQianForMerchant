//
//  SelectButton.m
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/22.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "SelectButton.h"

@interface SelectButton ()

@end

@implementation SelectButton

- (void)drawRect:(CGRect)rect {
    
    switch (_buttonApperance) {
        
        case ButtonApperanceSelected:
        {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"0xf61d4a"].CGColor);
            CGContextSetLineWidth(context, 2.0);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextMoveToPoint(context, 2 , rect.size.height/2);
            CGContextAddLineToPoint(context, rect.size.width/2-2, rect.size.height/5*4);
            CGContextAddLineToPoint(context, rect.size.width-2, rect.size.height/5);
            CGContextStrokePath(context);
        }
            break;
        case ButtonApperanceUnSelected:
        {
            
        }
            break;
        default:
            break;
    }
    

}

- (instancetype)init {
    if (self = [super init]) {
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithHexString:@"0xf61d4a"].CGColor;
    }
    return self;
}

- (void)setButtonApperance:(ButtonApperance)buttonApperance {
    if (buttonApperance != _buttonApperance) {
        _buttonApperance = buttonApperance;
        [self setNeedsDisplay];
    }
}



@end
