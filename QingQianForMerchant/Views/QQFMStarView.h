//
//  QQFMStarView.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/24.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQFMStarView : UIView

@property (nonatomic, assign) CGFloat commentPoint;

- (instancetype)initWithFrame:(CGRect)frame withTotalStar:(NSInteger)totalStar totalPoint:(CGFloat)totalPoint;

@end
