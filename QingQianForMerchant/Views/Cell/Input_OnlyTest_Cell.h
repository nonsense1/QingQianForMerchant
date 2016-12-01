//
//  Input_OnlyTest_Cell.h
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#define kCellIdentifier_Input_OnlyText_Cell_Text @"Input_OnlyText_Cell_Text"
#define kCellIdentifier_Input_OnlyText_Cell_Password @"Input_OnlyText_Cell_Password"
#define kCellIdentifier_Input_OnlyText_Cell_Captcha @"Input_OnlyText_Cell_Captcha"
#define kCellIdentifier_Input_OnlyText_Cell_Label @"Input_OnlyText_Cell_Label"
#define kCellIdentifier_Input_OnlyText_Cell_Image @"Input_OnlyText_Cell_Image"

#import <UIKit/UIKit.h>
#import "PhoneCodeButton.h"

@interface Input_OnlyTest_Cell : UITableViewCell
@property (nonatomic,strong,readonly) UITextField *textField;
@property (nonatomic,strong,readonly) PhoneCodeButton *verify_codeBtn;


@property (nonatomic,copy) void(^textValueChangedBlock)(NSString *);
@property (nonatomic,copy) void(^editDidBeginBlock)(NSString *);
@property (nonatomic,copy) void(^editDidEndBlock)(NSString *);
@property (nonatomic,copy) void(^phoneCodeBtnClickedBlock)(PhoneCodeButton *);


- (void)setPlaceholder:(NSString *)phStr value:(NSString *)valueStr showGuide:(NSString *)guideString;

/*只有cell为kCellIdentifier_Input_OnlyText_Cell_Image时起作用*/
- (void)setPlaceholderImageViewWithImage:(UIImage *)placeholderImage;

@end
