//
//  Input_OnlyTest_Cell.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/10/28.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "Input_OnlyTest_Cell.h"

@interface Input_OnlyTest_Cell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *clearBtn, *passwordBtn;
@property (nonatomic, strong) UIImageView *placeholderImageView;
@property (nonatomic, strong) UILabel *guideLabel;

@end

@implementation Input_OnlyTest_Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_guideLabel) {
            _guideLabel = [[UILabel alloc] init];
            [_guideLabel setFont:[UIFont systemFontOfSize:17]];
            [_guideLabel setTextColor:[UIColor colorWithHexString:@"0x000000" andAlpha:1.0]];
            [self.contentView addSubview:_guideLabel];
            [_guideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
                make.height.mas_equalTo(32);
                make.width.mas_equalTo(kScreen_Width/5);
                make.centerY.equalTo(self.contentView);
            }];
        }
        if (!_textField) {
            _textField = [[UITextField alloc] init];
            [_textField setFont:[UIFont systemFontOfSize:17]];
            [_textField setTextColor:[UIColor colorWithHexString:@"0xffffff" andAlpha:1.0]];
            [_textField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
            [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
            [_textField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
            [self.contentView addSubview:_textField];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(20);
                make.left.mas_equalTo(self.guideLabel.mas_right).offset(10.0);
                make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
        }
        
        if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Text]) {
            
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Captcha]){
            if (!_verify_codeBtn) {
                _verify_codeBtn = [[PhoneCodeButton alloc] initWithFrame:CGRectMake(kScreen_Width-80-kLoginPaddingLeftWidth, (44-25)/2, 80, 25)];
                [_verify_codeBtn addTarget:self action:@selector(phoneCodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_verify_codeBtn];
            }
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Password]){
            if (!_passwordBtn) {
                _textField.secureTextEntry = YES;
                _passwordBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width-44-kLoginPaddingLeftWidth, 0, 44, 44)];
                [_passwordBtn setImage:[UIImage imageNamed:@"password_unlook"] forState:UIControlStateNormal];
                [_passwordBtn addTarget:self action:@selector(passwordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:_passwordBtn];
            }
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Label]){
            
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_Cell_Image]){
            if (!_placeholderImageView) {
                _placeholderImageView = [[UIImageView alloc] init];
                [self.contentView addSubview:_placeholderImageView];
                [_placeholderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
                    make.centerY.equalTo(self.contentView);
                    make.width.height.mas_offset(32);
                }];
                
                [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(20);
                    make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
                    make.centerY.equalTo(self.contentView);
                    make.left.equalTo(_placeholderImageView.mas_right).offset(8.0);
                }];
            }
        }
    }
    return self;
}

- (void)prepareForReuse {
    self.textField.userInteractionEnabled = YES;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    
    self.editDidBeginBlock = nil;
    self.textValueChangedBlock = nil;
    self.editDidEndBlock = nil;
}


- (void)setPlaceholder:(NSString *)phStr value:(NSString *)valueStr showGuide:(NSString *)guideString{
    NSLog(@"%@",guideString);
    UIColor *color = nil;
    if (guideString.length == 0) {
        [self.guideLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(0);
            make.centerY.equalTo(self.contentView);
        }];
        color = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
    }else{
        color = [UIColor colorWithHexString:@"0x000000" andAlpha:0.5];
    }
    self.guideLabel.text = guideString;
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phStr?phStr:@"" attributes:@{NSForegroundColorAttributeName:color}];
    self.textField.text = valueStr;
}

- (void)setPlaceholderImageViewWithImage:(UIImage *)placeholderImage {
    [self.placeholderImageView setImage:placeholderImage];
}

#pragma mark Button
- (void)phoneCodeButtonClicked:(id)sender {
    if (self.phoneCodeBtnClickedBlock) {
        self.phoneCodeBtnClickedBlock(sender);
    }
}

#pragma mark - UIVeiw
- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.equalTo(self.contentView).offset(kLoginPaddingLeftWidth);
            make.right.equalTo(self.contentView).offset(-kLoginPaddingLeftWidth);
            make.bottom.equalTo(self.contentView);
        }];
    }
    self.backgroundColor = [UIColor clearColor];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
#pragma password
- (void)passwordBtnClicked:(UIButton *)button {
    _textField.secureTextEntry = !_textField.secureTextEntry;
    [button setImage:[UIImage imageNamed:_textField.secureTextEntry?@"password_unlook":@"password_look"] forState:UIControlStateNormal];
}

#pragma mark TextField
- (void)editDidBegin:(id)sender {
    self.lineView.backgroundColor = [UIColor whiteColor];
    if (_editDidBeginBlock) {
        _editDidBeginBlock(self.textField.text);
    }
    
}

- (void)editDidEnd:(id)sender {
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff" andAlpha:0.5];
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

- (void)textValueChanged:(id)sender {
    
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

@end
