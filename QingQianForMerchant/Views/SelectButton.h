//
//  SelectButton.h
//  QingQianForMerchant
//
//  Created by 丰收 on 2016/11/22.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ButtonApperance){
    ButtonApperanceSelected = 0,
    ButtonApperanceUnSelected,
};

@interface SelectButton : UIButton

@property (nonatomic, assign) ButtonApperance buttonApperance;

@end
