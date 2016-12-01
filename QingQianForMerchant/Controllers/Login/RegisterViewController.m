//
//  RegisterViewController.m
//  QingQianForMerchant
//
//  Created by 丰收 on 16/11/1.
//  Copyright © 2016年 UnionBusiness. All rights reserved.
//

#import "RegisterViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "Input_OnlyTest_Cell.h"
#import "SelectButton.h"
#import "TTTAttributedLabel.h"
#import "QQFMWebViewController.h"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,TTTAttributedLabelDelegate>

@property (nonatomic,strong) Register *myRegister;
@property (nonatomic,assign) RegisterMethodType methodeType;
@property (nonatomic,strong) TPKeyboardAvoidingTableView *myTableView;
@property (nonatomic,strong) UIButton *footerBtn, *backBtn;
@property (nonatomic,strong) SelectButton *selectBtn;

@end

@implementation RegisterViewController

+ (instancetype)vcWithMethodType:(RegisterMethodType)methodType registerObj:(Register *)obj {
    RegisterViewController *vc = [self new];
    vc.methodeType = methodType;
    vc.myRegister = obj;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联商通行证注册";
    if (!_myRegister) {
        self.myRegister = [[Register alloc] init];
    }
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[Input_OnlyTest_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Text];
        [tableView registerClass:[Input_OnlyTest_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Captcha];
        [tableView registerClass:[Input_OnlyTest_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Password];
        tableView.backgroundColor = kColorTabBG;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    [self setupNav];
    self.myTableView.tableHeaderView = [self customHeaderView];
    self.myTableView.tableFooterView=[self customFooterView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

#pragma mark - Nav
- (void)setupNav {
    if (self.navigationController.childViewControllers.count <= 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBtnTitle:@"" target:self action:@selector(dismissSelf)];
    }
}
- (void)dismissSelf {
}

#pragma mark - Top Bottom Header Footer
- (UIView *)customHeaderView {
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.15*kScreen_Height)];
    headerV.backgroundColor = [UIColor clearColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    headerLabel.textColor = kColor222;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = @"";
    [headerLabel setCenter:headerV.center];
    [headerV addSubview:headerLabel];
    return headerV;
}

- (UIView *)customFooterView {
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 200)];
    
    _footerBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"注册" andFrame:CGRectMake(kLoginPaddingLeftWidth, 20, kScreen_Width-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendRegister)];
    [footerV addSubview:_footerBtn];
    __weak typeof(self) weakSelf = self;
    RAC(self,footerBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, myRegister.compPassword),
                                                             RACObserve(self, myRegister.phone),
                                                             RACObserve(self, myRegister.email),
                                                             RACObserve(self, myRegister.password),
                                                             RACObserve(self, myRegister.captcha),
                                                             RACObserve(self, myRegister.isAgree)]
                                                    reduce:^id(NSString *compPassword,
                                                               NSString *phone,
                                                               NSString *email,
                                                               NSString *password,
                                                               NSString *captcha,
                                                               NSString *isAgree){
                                                        BOOL enabled = (compPassword.length > 0 && password.length > 0 && ((weakSelf.methodeType == RegisterMethodEmail && email.length >0)||(weakSelf.methodeType == RegisterMethodPhone && phone.length > 0 && captcha.length > 0)) && [isAgree isEqualToString:@"agree"] && [compPassword isEqualToString:password]);
                                                        return @(enabled);
    }];
    
    
    TTTAttributedLabel *agreementLabel = ({
        TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.linkAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xf61d4a"]};
        label.numberOfLines = 0;
        label.delegate = self;
        label;
    });
    NSString *tipStr = @"阅读并同意用户协议";
    agreementLabel.text = tipStr;
    [agreementLabel addLinkToTransitInformation:@{} withRange:[tipStr rangeOfString:@"用户协议"]];
    [footerV addSubview:agreementLabel];
    [agreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(footerV);
        make.size.mas_equalTo(CGSizeMake(130, 30));
        make.top.equalTo(_footerBtn.mas_bottom).offset(20);
    }];
    
    _selectBtn = [[SelectButton alloc] init];
    _selectBtn.buttonApperance = ButtonApperanceUnSelected;
    [_selectBtn addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerV addSubview:_selectBtn];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.mas_equalTo(agreementLabel.mas_left);
        make.centerY.equalTo(agreementLabel);
    }];
    
    _backBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithHexString:@"0xf61d4a"] forState:UIControlStateNormal];
        [button setTitle:@"已有账号,直接登录" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backToLogin) forControlEvents:UIControlEventTouchUpInside];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.centerX.equalTo(footerV);
            make.top.equalTo(_selectBtn.mas_bottom).offset(20);
        }];
        button;
    });

    return footerV;
}


#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = _methodeType == RegisterMethodEmail?3:4;
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    if (_methodeType == RegisterMethodEmail) {
        cellIdentifier = (indexPath.row == 2?kCellIdentifier_Input_OnlyText_Cell_Password:kCellIdentifier_Input_OnlyText_Cell_Text);
    }else{
        cellIdentifier = (indexPath.row == 0?kCellIdentifier_Input_OnlyText_Cell_Captcha:indexPath.row == 1?kCellIdentifier_Input_OnlyText_Cell_Text:kCellIdentifier_Input_OnlyText_Cell_Text);
    }
    Input_OnlyTest_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textField.textColor = [UIColor colorWithHexString:@"0x000000" andAlpha:0.8];
    __weak typeof(self) weakSelf = self;
    if (_methodeType == RegisterMethodEmail) {
        if (indexPath.row == 0) {
            [cell setPlaceholder:@"手机号" value:self.myRegister.phone showGuide:@""];
            cell.textValueChangedBlock = ^(NSString *valueStr) {
                weakSelf.myRegister.phone = valueStr;
            };
        }else if (indexPath.row == 1) {
            cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
            [cell setPlaceholder:@"邮箱" value:self.myRegister.email showGuide:@""];
            cell.textValueChangedBlock = ^(NSString *valueStr) {
                weakSelf.myRegister.email = valueStr;
            };
        }else if (indexPath.row == 2){
            [cell setPlaceholder:@"设置密码" value:self.myRegister.password showGuide:@""];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myRegister.password = valueStr;
            };
        }
    }else {
        if (indexPath.row == 0) {
            [cell setPlaceholder:@"  您的手机号" value:self.myRegister.phone showGuide:@"手机号"];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myRegister.phone = valueStr;
            };
            cell.phoneCodeBtnClickedBlock = ^(PhoneCodeButton *btn){
                [weakSelf phoneCodeBtnClicked:btn];
            };
        }else if (indexPath.row == 1){
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell setPlaceholder:@"  手机短信验证码" value:self.myRegister.captcha showGuide:@"验证码"];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myRegister.captcha = valueStr;
            };
        }else if (indexPath.row == 2) {
            [cell setPlaceholder:@"  由5-20位字母数字组成" value:self.myRegister.password showGuide:@"设置密码"];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myRegister.password = valueStr;
            };
        }else if (indexPath.row == 3) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [cell setPlaceholder:@"  由5-20位字母数字组成" value:self.myRegister.compPassword showGuide:@"确认密码"];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myRegister.compPassword = valueStr;
            };
            cell.editDidEndBlock = ^(NSString *valueStr) {
                [self comparePassword];
            };
        }
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kLoginPaddingLeftWidth];
    return cell;
}

#pragma mark -TTTAttributeLabelDelegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    QQFMWebViewController *vc = [[QQFMWebViewController alloc] initWithAddress:@"http://www.fanshow.xyz"];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma maek Btn click
- (void)sendRegister {
    DebugLog(@"注册");
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
}

- (void)phoneCodeBtnClicked:(PhoneCodeButton *)sender {
    
    if (![_myRegister.phone isPhoneNo]) {
        [self showMessage:@"手机号码格式有误" withDuring:2];
        
        return;
    }
    sender.enabled = NO;
    [sender startUpTimer];
}

- (void)backToLogin {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)agreeClick:(SelectButton *)sender {
    if (sender.buttonApperance == ButtonApperanceSelected) {
        sender.buttonApperance = ButtonApperanceUnSelected;
        _myRegister.isAgree = @"disagree";
    }else{
        sender.buttonApperance = ButtonApperanceSelected;
        _myRegister.isAgree = @"agree";
    } 
}
# pragma mark
- (void)comparePassword {
    if (![self.myRegister.password isEqualToString:self.myRegister.compPassword]) {
        [self showMessage:@"两次输入的密码不一致,请核对后注册" withDuring:2.0];
    }
}

@end
